#!/bin/bash


mkdir cache -rf
export XMAKE_GLOBALDIR=$(pwd)/cache
# export XMAKE_GLOBALDIR=cache

xmake g --network=private
xmake f -y -p cross \
    -vD -P .
xmake -vD -P .
xmake install -o install
