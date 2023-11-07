## Giflib 5.2.1 Vuln Poc
Giflib Version 5.2.1

## Description
Heap Based Overflow on Giflib's gif2rgb program. Crashes folder contains the sample that triggers the crash. 

## Installation via Dockerfile
docker build --rm -t giflib-vuln -f Dockerfile .

docker run -it --rm giflib-vuln /bin/bash

./poc.sh

[!Crash](crash1.png)
[!Output](output1.png)

## Files Description
1. crashes.zip ==>  contains the sample which can trigger the crash.

2. poc.sh ==> contains a bash script that executes the vulnerable gif2rgb program with the input that triggers the crash.

3. Dockerfile ==> dockerfile to create the environment and setup giflib 5.2.1 for easy bug replication.



## Installation without Docker
Environment: Ubuntu 22.04 LTS

wget https://yer.dl.sourceforge.net/project/giflib/giflib-5.2.1.tar.gz

tar -xf giflib-5.2.1.tar.gz

cd giflib-5.2.1

make CFLAGS="-std=gnu99 -fPIC -Wall -Wno-format-truncation -ggdb -fsanitize=address,undefined,leak,integer -fno-omit-frame-pointer"

## Usage
./giflib-5.2.1/gif2rgb -o out /tmp/crashes/sample

## Roadmap
Exploit for the bug is under development.

