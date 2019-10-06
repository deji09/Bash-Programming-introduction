#!/bin/bash
# trackpro Installation script

echo "Welcome to the trackpro installer"
echo "With this installer there are two types of installation"
echo "For more information please read the README file on Github"
echo "Please select your preferred option:"

system_user=$(whoami)

function globalInstall() {
    local installPath=/usr/local/bin/trackpro
    local configPath=/etc
    local profilePath=/etc/profile
    echo
    if [ "$system_user" == "root" ]; then
        echo "Global Installation started"
        mkdir $installPath
        cp -v ./source/trackpro.sh $installPath/trackpro
        cp -vr ./source/scripts $installPath
        cp -v ./source/config/trackpro.conf $configPath
        echo "# Enables global trackpro installation " >> $profilePath
        echo export PATH=$installPath:$PATH >> $profilePath
        source $profilePath
        echo
        echo "Installation successful"
    else 
        echo "Installation aborted: Superuser privleges required"
    fi
}

function localInstall() {
    local installPath=/home/$system_user/bin
    local configPath=/home/$system_user/.trackpro
    local profilePath=/home/$system_user/.bashrc
    echo
    echo "Local Installation started"
    mkdir $installPath
    mkdir $configPath
    cp -v ./source/trackpro.sh $installPath/trackpro
    cp -vr ./source/scripts $installPath
    cp -v ./source/config/trackpro.conf $configPath
    echo "# Enables local trackpro installation " >> $profilePath
    echo export PATH=$installPath/trackpro:$PATH >> $profilePath
    source $profilePath
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