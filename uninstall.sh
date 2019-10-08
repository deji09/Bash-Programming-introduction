#!/bin/bash
# trackpro Uninstall script

# Introduction message
echo "Welcome to the trackpro uninstaller"
echo "We are sad you are leaving us"

# Defines some global variables
# Stores the first two arguments of the function
# Used to determine whether to prompt the user and/or delete configuration files
option_1=$1
option_2=$2
# Stores the appropriate global and local installation paths of trackpro
globalInstallPath=/usr/local/bin/trackpro
localInstallPath=$HOME/bin/trackpro

# Checks if the user has ran the script with a --deep argument and if so 
# deletes the appropriate configuration file
deleteConfig() {
    if [ "$option_1" == "--deep" ] || [ "$option_2" == "--deep" ]; then
        rm -rvf $1
    fi
}

# Deletes files for uninstallation
# Takes the paths of the installation, configuration files and appropriate 
# profile as parameters
deleteFiles() {
    # Renames the parameters
    local installPath=$1
    local configPath=$2
    local profilePath=$3
    # Deletes the installation
    rm -rvf $installPath
    # Removes the trackpro installation from the PATH at launch
    sed '/trackpro/d' -i $profilePath
    # Deletes configuration files if appropriate arguments were applied
    deleteConfig $configPath
    echo "Uninstallation successful"
    # Seems to be the only reliable way I've found to reload the path within the script
    # Although it may still be temperamental 
    exec /bin/bash
}

# Used to uninstall a global installation of trackpro for all users
globalUnistall() {
    # Stores appropriate variables for the installation and configuration files
    local installPath=$globalInstallPath
    local configPath=/etc/trackpro.conf
    # Stores the profile to modify to remove the trackpro installation from the PATH 
    local profilePath=/etc/profile
    # Checks if the user is root
    if [ "$(whoami)" == "root" ]; then
        # Uninstalls trackpro by passing parameters to target a global installation
        deleteFiles $installPath $configPath $profilePath
    else
        echo "Uninstallation aborted: Superuser privleges required"
    fi
}

# Used to uninstall a local installation of trackpro for a single user
localUninstall() {
    # Stores appropriate variables for the installation and configuration files
    local installPath=$localInstallPath
    local configPath=$HOME/.trackpro
    # Stores the profile to modify to remove the trackpro installation from the PATH 
    local profilePath=$HOME/.bashrc
    # Uninstalls trackpro by passing parameters to target a local installation
    deleteFiles $installPath $configPath $profilePath
}

# Serves as a main method for uninstalling trackpro
uninstall() {
    echo "Uninstallation started"
    # Checks if there is a folder consistent with a global installation
    if [ -d "$globalInstallPath" ]; then
        globalUnistall
    # Checks if there is a folder consistent with a local installation
    elif [ -d "$localInstallPath" ]; then
        localUninstall
    else
        echo "Uninstallation aborted: No installation found"
    fi
}


# Checks if the user has entered -y as an argument which prevents the user from 
# being asked about whether to uninstall
if [ "$option_1" == "-y" ] || [ "$option_2" == "-y" ]; then
    uninstall
else
    # Credits to Stackoverflow user Myrddin Emrys
    # Link: https://stackoverflow.com/questions/226703/how-do-i-prompt-for-yes-no-cancel-input-in-a-linux-shell-script
    # Reads input from the user as yn
    read -p "Are you sure you want to uninstall trackpro [N/y] " yn
    # Starts uninstalling if the user enters an input beginning with a y
    # And exits otherwise
    case $yn in
        [Yy]* )
            uninstall
        ;;
        * )
            echo "Uninstall canceled"
        ;;
    esac
fi
