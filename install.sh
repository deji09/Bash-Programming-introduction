#!/bin/bash
# trackpro Installation script

echo "Welcome to the trackpro installer"
echo "With this installer there are two types of installation"
echo "For more information please read the README file on Github"
echo "Please select your preferred option:"

system_user=$(whoami)

function globalInstall() {
    local installPath=/usr/local/bin
    local configPath=/etc
    echo
    if [ "$system_user" == "root" ]; then
        cp -v ./source/trackpro.sh $installPath/trackpro
        cp -vr ./source/trackpro-scripts $installPath
        cp -v ./source/config/trackpro.conf $configPath
        echo
        echo "Installation successful"
    else 
        echo "Install aborted: Superuser privleges required"
    fi
}

function localInstall() {
    local installPath=/home/$system_user/bin
    local configPath=/home/$system_user/.trackpro
    local bashrcPath=/home/$system_user/.bashrc
    echo
    mkdir $installPath
    mkdir $configPath
    cp -v ./source/trackpro.sh $installPath/trackpro
    cp -vr ./source/trackpro-scripts $installPath
    cp -v ./source/config/trackpro.conf $configPath
    echo export PATH=/home/$system_user/bin:$PATH >> $bashrcPath
    source $bashrcPath
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
        # "Option 3")
        #     echo "you chose choice $REPLY which is $opt"
        #     ;;
        "Exit Installation")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done