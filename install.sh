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
    echo
    if [ "$system_user" == "root" ]; then
        mkdir $installPath
        cp -v ./source/trackpro.sh $installPath/trackpro
        cp -vr ./source/scripts $installPath
        cp -v ./source/config/trackpro.conf $configPath
        echo
    else 
        echo "Install aborted: Superuser privleges required"
    fi
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
            echo
            echo "Local"
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