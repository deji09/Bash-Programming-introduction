#!/bin/bash
# Changes settings in configuaration files that can be set by the user

configPath=$1
source $configPath

echo "Current global settings:"
echo "Configuration file: $configPath"
echo "Default editor: $editor"
echo "Auto Update: $autoUpdate"
echo

changeStr() {
    echo
    local displayString=$1
    local variableToChange=$2
    # Reads input from the user
    read -p "$displayString" input
    # Removes the current editor variable from the config
    grep -v "$variableToChange" $configPath > $configPath.tmp && mv $configPath.tmp $configPath
}

editor() {
    # Asks the user for input and deletes the current command from the file
    changeStr "New editor command: " editor
    # Adds the new editor variable to the file
    echo -e "editor=$input" >> $configPath
}

# Credits to askubuntu user Dennis Williamson
# Link: https://askubuntu.com/questions/1705/how-can-i-create-a-select-menu-in-a-shell-script 
# Prints to the console
PS3='Please enter your choice: '
# Defines the options for a user to select
options=("Default editor" "Exit")
# Allows the user to type in their preffered option
select opt in "${options[@]}"
do  
    # Chooses the function based on the user's statement
    case $opt in
        "Default editor")
            editor
            break
        ;;
        # "Change repository name")
        #     echo "Repository name"
        #     break
        "Exit")
            break
        ;;
        *) 
        # Prints what the user's typed
        echo "Invalid Option: $REPLY"
        echo "Please enter an invalid"
        ;;
    esac
done
