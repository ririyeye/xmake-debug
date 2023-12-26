#!/bin/bash


mkdir cache -rf
export XMAKE_GLOBALDIR=$(pwd)/cache
# export XMAKE_GLOBALDIR=cache

xmake g --network=private
xmake f -y \
    -vD
xmake -vD -w
xmake install -o install
