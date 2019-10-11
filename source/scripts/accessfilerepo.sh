#!bin/bash
#
echo "What file repo do you want to access?";read input;path=$(find -name $input -type d);cd $path;