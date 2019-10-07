#!/bin/bash
# trackpro Uninstall script

echo "Welcome to the trackpro uninstaller"
echo "We are sad you are leaving us"

system_user=$(whoami)

globalInstallPath=/usr/local/bin/trackpro
localInstallPath=/home/$system_user/bin/trackpro

function globalUnistall() {
    if [ "$system_user" == "root" ]; then
        rm -rf $globalInstallPath
    else
        echo "Installation aborted: Superuser privleges required"
    fi
}

function localUninstall() {

}

function findInstallation() {
    if [ -e  ]; then
    else
    fi
}

function deleteConfig() {
    
}

function uninstall() {
    echo "Uninstall started"
    if [ $1 == "--deep" ]; then
        deleteConfig
    fi
}

if [ $1 != "-y" && $2 != "-y" ]; then
    read -p "Are you sure you want to uninstall trackpro [N/y] " yn
    case $yn in
        [Yy]* )
            uninstall
            exit
        ;;
        * )
            echo "Uninstall canceled"
            exit
        ;;
    esac
else
    uninstall
fi