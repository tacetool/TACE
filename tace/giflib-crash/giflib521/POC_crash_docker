FROM ubuntu:22.04 as base

# Install dependencies
RUN set -i '/deb-src/s/^# //' /etc/apt/sources.list \
    && apt update -y \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
        g++ \
        git \
        wget \
        gcc \
        build-essential \
        python3 \
        python3-pip \
        vim \
        tar \
        unzip \
        python2 \
    && ln -s /usr/bin/python3 /usr/bin/python

WORKDIR /tmp
#Copy the crashes.zip, poc.sh, README files into the container
COPY crashes.zip /tmp
COPY poc.sh /tmp
COPY README.md /tmp

#Download and compile Giflib 5.2.1
RUN wget https://yer.dl.sourceforge.net/project/giflib/giflib-5.2.1.tar.gz \
    && tar -xf giflib-5.2.1.tar.gz \
    && cd giflib-5.2.1 \
    && make CFLAGS="-std=gnu99 -fPIC -Wall -Wno-format-truncation -ggdb -fsanitize=address,undefined -fno-omit-frame-pointer" \
    && cd .. \
    && unzip crashes.zip \
    && chmod +x poc.sh

WORKDIR /tmp

