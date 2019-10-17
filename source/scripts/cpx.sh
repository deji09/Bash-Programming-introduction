#!/bin/bash

if [ ! -d "$2" ]; then
    mkdir -vp "$2"
fi
cp -vR "$1" "$2"