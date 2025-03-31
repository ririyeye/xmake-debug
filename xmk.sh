#!/bin/bash


mkdir cache -rf
export XMAKE_GLOBALDIR=$(pwd)/cache
# export XMAKE_GLOBALDIR=cache

xmake g --network=private
xmake f -y -p cross \
    --sdk=/opt/toolchain/arm-himix100-linux/arm/arm-himix100-linux \
    -vD -P .
xmake -vD -P .
xmake install -o install
