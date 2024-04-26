#!/bin/bash


mkdir cache -p
export XMAKE_GLOBALDIR=$(pwd)/cache
# export XMAKE_GLOBALDIR=cache

xmake g --network=private
xmake f -y \
    --sdk=/home/wangyang/toolchain/gcc-linaro-5.4.1-2017.05-x86_64_arm-linux-gnueabihf \
    -vD
xmake -vvD -w
xmake install -o install
