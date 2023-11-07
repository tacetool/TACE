# This docker image required to provide dev environment
# to build set of tools with TACE patches.
# basic deps are presented though add up necessary
# required for the task.

#
# The base image
#
FROM ubuntu:20.04 AS builder

# Install dependencies
RUN sed -i '/deb-src/s/^# //' /etc/apt/sources.list \
    && apt update \
    && DEBIAN_FRONTEND=noninteractive apt build-dep qemu -y \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
        cargo \
        clang-10 \
        cmake \
        g++ \
        git \
        libz3-dev \
        llvm-10-dev \
        llvm-10-tools \
        ninja-build \
        python2 \
        python3-pip \
        zlib1g-dev \
        less \
        emacs \
    && ln -s /usr/bin/python2 /usr/bin/python

# Build AFL.
RUN git clone -b v2.56b https://github.com/google/AFL.git afl \
    && cd afl \
    && make

# Download the LLVM sources already so that we don't need to get them again when
# SymCC changes
RUN git clone -b llvmorg-10.0.1 --depth 1 https://github.com/llvm/llvm-project.git /llvm_source

# Build a version of SymCC with the simple backend to compile libc++
COPY . /symqemu

#
# Build SymCC with the simple backend
#
FROM builder AS builder_simple
WORKDIR /symcc_build_simple
RUN cmake -G Ninja \
        -DQSYM_BACKEND=OFF \
        -DCMAKE_BUILD_TYPE=RelWithDebInfo \
        -DZ3_TRUST_SYSTEM_VERSION=on \
        /symqemu/symcc \
        && ninja
#
# Build libc++ with SymCC using the simple backend
#
FROM builder_simple AS builder_libcxx
WORKDIR /libcxx_symcc
RUN export SYMCC_REGULAR_LIBCXX=yes SYMCC_NO_SYMBOLIC_INPUT=yes \
  && mkdir /libcxx_symcc_build \
  && cd /libcxx_symcc_build \
  && cmake -G Ninja /llvm_source/llvm \
  -DLLVM_ENABLE_PROJECTS="libcxx;libcxxabi" \
  -DLLVM_TARGETS_TO_BUILD="X86" \
  -DLLVM_DISTRIBUTION_COMPONENTS="cxx;cxxabi;cxx-headers" \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_INSTALL_PREFIX=/libcxx_symcc_install \
  -DCMAKE_C_COMPILER=/symcc_build_simple/symcc \
  -DCMAKE_CXX_COMPILER=/symcc_build_simple/sym++ \
  && ninja distribution \
  && ninja install-distribution


#
# Build SymCC with the Qsym + TACE
#
FROM builder_libcxx AS builder_qsym
WORKDIR /symcc_build
RUN cmake -G Ninja \
        -DQSYM_BACKEND=ON \
        -DCMAKE_BUILD_TYPE=RelWithDebInfo \
        -DZ3_TRUST_SYSTEM_VERSION=ON \
        /symqemu/symcc \
    && ninja \
    && ln -s /symcc_build/symcc /symcc_build/tace \
    && ln -s /symcc_build/sym++ /symcc_build/tace++ \
    && cargo install --path /symqemu/symcc/util/symcc_fuzzing_helper \
    && mkdir /tmp/output

#
# Build SymQEMU with the TACE
#
FROM builder_qsym AS builder_symqemu
WORKDIR /symqemu/build
RUN /symqemu/configure --audio-drv-list= \
               --disable-bluez \
               --disable-sdl \
               --disable-gtk \
               --disable-vte \
               --disable-opengl \
               --disable-virglrenderer \
               --disable-werror \
               --target-list=x86_64-linux-user \
               --enable-capstone \
               --symcc-source=/symqemu/symcc/ \
               --symcc-build=/symcc_build/ \
               --enable-debug \
               --enable-trace-backends=log \
               --enable-profiler \
     && make \
     && ln -s /symqemu/build/x86_64-linux-user/symqemu-x86_64 /usr/bin/taceqemu

ENV PATH /symcc_build:$PATH
ENV AFL_PATH /afl
ENV AFL_CC clang-10
ENV AFL_CXX clang++-10
ENV SYMCC_LIBCXX_PATH=/libcxx_symcc_install
WORKDIR /tmp
COPY ./symcc/test/test1_loop.c /tmp

#
# To test. Use sanjay1_loop test that demonstrates the issues with deps and branches
# cp /symqemu/symcc/test/sanjay1_loop.c /tmp/ && cd /tmp
# cc -O2 -o test.elf /tmp/sanjay1_loop.c
# echo 'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA' > input 
# SYMCC_INPUT_FILE=/tmp/input taceqemu /tmp/input
# Check folder /tmp/output for generated test cases, also log is going to be printed
#
#
# Or just run quicktest.h
#

