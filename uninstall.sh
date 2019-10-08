#!/bin/bash
# trackpro Uninstall script

echo "Welcome to the trackpro uninstaller"
echo "We are sad you are leaving us"

system_user=$(whoami)
option_1=$1
option_2=$2

deleteConfig() {
    if [ "$option_1" == "--deep" ] || [ "$option_2" == "--deep" ]; then
        rm -rvf $1
    fi
}

globalUnistall() {
    local configPath=/etc/trackpro.conf
    local profilePath=/etc/profile
    if [ "$system_user" == "root" ]; then
        rm -rvf $globalInstallPath
        sed '/trackpro/d' -i $profilePath
        deleteConfig $configPath
        echo "Uninstallation successful"
    else
        echo "Uninstallation aborted: Superuser privleges required"
    fi
}

localUninstall() {
    local configPath=$HOME/.trackpro
    local profilePath=$HOME/.bashrc
    rm -rvf $localInstallPath
    sed '/trackpro/d' -i $profilePath
    deleteConfig $configPath
    echo "Uninstallation successful"
}

uninstall() {
    local globalInstallPath=/usr/local/bin/trackpro
    local localInstallPath=$HOME/bin/trackpro
    echo "Uninstallation started"
    if [ -d "$globalInstallPath" ]; then
        globalUnistall
    elif [ -d "$localInstallPath" ]; then
        localUninstall
    else
        echo "Uninstallation aborted: No installation found"
    fi
}

if [ "$option_1" == "-y" ] || [ "$option_2" == "-y" ]; then
    uninstall
else
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
fi