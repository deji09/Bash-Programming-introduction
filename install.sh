#!/bin/bash
# trackpro Installation script

# Used to conduct a generic install which uses passed parameters to configure it for a 
# global or local installation
install() {
    # Stores the passed parameters into readable values
    installPath=$1 
    configPath=$2
    profilePath=$3
    # Checks if there isn't an installation directory already
    if [ ! -d $installPath ]; then 
        # Creates the path for the installation
        mkdir -pv $installPath
    fi
    # Copies the main trackpro application
    cp -v ./source/trackpro.sh $installPath/trackpro
    # Copies the additional scripts
    cp -vr ./source/scripts $installPath
    # Checks if there's alrready a configuaration file
    if [ ! -f $configPath ]; then
        # Copies the main configuration file
        cp -v ./source/config/trackpro.conf $configPath
    fi
    # Edits the user's PATH at launch so the user can just type trackpro in every directory
    echo -e "\n# trackpro\nexport PATH=\"$installPath:\$PATH"\" >> $profilePath
    # Edits the user's PATH for the current session for the same reason
    # export PATH="$installPath:$PATH"
    # source $installPath
    echo
    echo "Installation successful"
}

# Used to conduct a global installation which can be used for multiple users
globalInstall() {
    # Stores where trackpro will be installed
    local installPath=/usr/local/bin/trackpro
    # Stores where the main trackpro configuration file will be
    local configPath=/etc/trackpro.conf
    # Stores where the user's bash profile is located
    local profilePath=/etc/profile
    echo
    # Checks if the user is root
    if [ "$(whoami)" == "root" ]; then
        echo "Global Installation started"
        # Installs the application passing in the appropriate values
        install $installPath $configPath $profilePath
        # Edits the user's PATH for the current session for the same reason
        export PATH="$installPath:$PATH"
    else
        echo "Installation aborted: Superuser privleges required"
    fi
}

# Used to conduct a local installation used by only one user
localInstall() {
    # Stores where trackpro will be installed
    local installPath=$HOME/bin/trackpro
    # Stores where the main trackpro configuration file will be
    local configPath=$HOME/.trackpro
    # Stores where the user's bash profile is located
    local profilePath=$HOME/.bashrc
    echo
    echo "Local Installation started"
    # Checks if there isn't a configuration directory already
    if [ ! -d $configPath ]; then 
        # Creates the directory for the main configuration file
        mkdir -pv $configPath
    fi
    # Installs the application passing in the appropriate values
    install $installPath $configPath $profilePath
    # Seems to be the only reliable way I've found to reload the path for a local install within the script
    exec /bin/bash
}

# Introduction message
echo "Welcome to the trackpro installer"
echo "With this installer there are two types of installation"
echo "For more information please read the README file on Github"
echo "Please select your preferred option:"

# Credits to askubuntu user Dennis Williamson
# Link: https://askubuntu.com/questions/1705/how-can-i-create-a-select-menu-in-a-shell-script 
# Prints to the console
PS3='Please enter your choice: '
# Defines the options for a user to select
options=("Global" "Local" "Exit Installation")
# Allows the user to type in their preffered option
select opt in "${options[@]}"
do  
    # Chooses the function based on the user's statement
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
        *) 
        # Prints what the user's typed
        echo "Invalid Option: $REPLY"
        echo "Please enter an invalid"
        ;;
    esac
done
