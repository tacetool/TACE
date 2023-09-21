#!/bin/sh
#
# Usage, run from build/ folder or specify CONFIGURE variable to point to `configure` tool
# We assuming that symcc build is inside symcc folder. All necessary patched are there already.
# in case of changes just rebuild first symcc...or use dockerfile.
# Specify only abs paths for symcc sources and build

# Configure by default
CONFIGURE="${CONFIGURE:-../configure}"
SYMCC_SOURCE="${SYMCC_SOURCE:-../symcc}"
SYMCC_BUILD="${SYMCC_BUILD}"
"${CONFIGURE}" --audio-drv-list= \
	       --disable-bluez \
	       --disable-sdl \
	       --disable-gtk \
	       --disable-vte \
	       --disable-opengl \
	       --disable-virglrenderer \
	       --disable-werror \
	       --target-list=x86_64-linux-user \
	       --enable-capstone \
	       --symcc-source="${SYMCC_SOURCE}" \
	       --symcc-build="${SYMCC_BUILD}" \
	       --enable-debug \
	       --enable-trace-backends=log \
	       --enable-profiler

# clean & make to build from scratch
make clean && make
