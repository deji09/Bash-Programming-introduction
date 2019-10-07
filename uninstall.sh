#!/bin/bash
# trackpro Uninstall script

echo "Welcome to the trackpro uninstaller"
echo "We are sad you are leaving us"

system_user=$(whoami)
option_1=$1

function deleteConfig() {
    if [ option_1 == "--deep" ]; then
        rm -f $1
    fi
}

function globalUnistall() {
    local configPath=/etc/trackpro.conf
    local profilePath=/etc/profile
    if [ "$system_user" == "root" ]; then
        rm -rvf $globalInstallPath
        sed '/trackpro/d' -i $profilePath
        deleteConfig $configPath
    else
        echo "Installation aborted: Superuser privleges required"
    fi
}

function localUninstall() {
    local configPath=/home/$system_user/.trackpro
    local profilePath=/home/$system_user/.bashrc
    rm -rf $localInstallPath
    sed '/trackpro/d' -i $profilePath
    deleteConfig $configPath
}

function uninstall() {
    local globalInstallPath=/usr/local/bin/trackpro
    local localInstallPath=/home/$system_user/bin/trackpro
    echo "Uninstall started"
    if [ -d "$globalInstallPath" ]; then
        globalUnistall
    elif [ -d "$localInstallPath" ]; then
        localUninstall
    else
        echo "Installation aborted: No installation found"
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