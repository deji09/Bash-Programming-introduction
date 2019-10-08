#!/bin/bash
# trackpro Uninstall script

echo "Welcome to the trackpro uninstaller"
echo "We are sad you are leaving us"

system_user=$(whoami)
option_1=$1
option_2=$2
globalInstallPath=/usr/local/bin/trackpro
localInstallPath=$HOME/bin/trackpro

deleteConfig() {
    if [ "$option_1" == "--deep" ] || [ "$option_2" == "--deep" ]; then
        rm -rvf $1
    fi
}

deleteFiles() {
    local installPath=$1
    local configPath=$2
    local profilePath=$3
    rm -rvf $installPath
    sed '/trackpro/d' -i $profilePath
    deleteConfig $configPath
    echo "Uninstallation successful"
    exec /bin/bash
}

globalUnistall() {
    local installPath=$globalInstallPath
    local configPath=/etc/trackpro.conf
    local profilePath=/etc/profile
    if [ "$system_user" == "root" ]; then
        deleteFiles $installPath $configPath $profilePath
    else
        echo "Uninstallation aborted: Superuser privleges required"
    fi
}

localUninstall() {
    local installPath=$localInstallPath
    local configPath=$HOME/.trackpro
    local profilePath=$HOME/.bashrc
    deleteFiles $installPath $configPath $profilePath
}

uninstall() {
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
        ;;
        * )
            echo "Uninstall canceled"
        ;;
    esac
fi
