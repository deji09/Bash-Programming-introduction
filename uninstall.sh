#!/bin/bash
# trackpro Uninstall script

echo "Welcome to the trackpro uninstaller"
echo "We are sad you are leaving us"

read -p "Are you sure you want to uninstall trackpro [N/y] " yn
case $yn in
    [Yy]* )
        echo "Uninstall started"
        exit
    ;;
    * )
        echo "Uninstall canceled"
        exit
    ;;
esac