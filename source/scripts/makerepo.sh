#!/bin/bash
# Creates a repository
target=$1
configPath=$2

make() {
    echo make
    mkdir $target
    
    # Edits the user's PATH at launch so the user can just type trackpro in every directory
    # echo -e "\nexport PATH=\"$installPath:\$PATH"\" >> $profilePath
    # Removes the current configPath variable from the config
    grep -v "repoPaths" $configPath > $configPath.tmp && mv $configPath.tmp $configPath
    # Adds the new configPath variable to the file
    echo -e "repoPaths=$input" >> $configPath
}

# Credits to Stackoverflow user Myrddin Emrys
# Link: https://stackoverflow.com/questions/226703/how-do-i-prompt-for-yes-no-cancel-input-in-a-linux-shell-script
# Reads input from the user as yn
read -p "Are you sure you want to create a repository at path [Y/n] " yn
# Starts uninstalling if the user enters an input beginning with a y
# And exits otherwise
case $yn in
    [Nn]* )
        ;;
    * )
        make
        ;;
    esac