#!/bin/bash
# trackpro Installation script

echo "Welcome to the trackpro installer"
echo "With this installer there are two types of installation"
echo "For more information please read the README file on Github"
echo "Please select your preferred option:"

system_user=$(whoami)

function globalInstall() {
    local installPath=/usr/local/bin/trackpro
    local configPath=/etc/trackpro.conf
    local profilePath=/etc/profile
    echo
    if [ "$system_user" == "root" ]; then
        echo "Global Installation started"
        mkdir -pv $installPath
        cp -v ./source/trackpro.sh $installPath/trackpro
        cp -vr ./source/scripts $installPath
        cp -v ./source/config/trackpro.conf $configPath
        echo -e "\n# trackpro\nexport PATH=\"$installPath:\$PATH"\" >> $profilePath
        export PATH="$installPath:$PATH"
        echo
        echo "Installation successful"
    else
        echo "Installation aborted: Superuser privleges required"
    fi
}

function localInstall() {
    local installPath=$HOME/bin/trackpro
    local configPath=$HOME/.trackpro
    local profilePath=$HOME/.bashrc
    echo
    echo "Local Installation started"
    mkdir -pv $installPath
    mkdir -pv $configPath
    cp -v ./source/trackpro.sh $installPath/trackpro
    cp -vr ./source/scripts $installPath
    cp -v ./source/config/trackpro.conf $configPath
    echo -e "\n# trackpro\nexport PATH=\"$installPath:\$PATH"\" >> $profilePath
    export PATH="$installPath:$PATH"
    echo
    echo "Installation successful"
}

PS3='Please enter your choice: '
options=("Global" "Local" "Exit Installation")
select opt in "${options[@]}"
do
    case $opt in
        "Global")
            globalInstall
            break
        ;;
        "Local")
            localInstall
            break
        ;;
        "Exit Installation")
            break
        ;;
        *) echo "invalid option $REPLY";;
    esac
done