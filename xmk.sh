#!/bin/bash

xmake f -y \
    -vD
xmake -vD -w
xmake install -o install
