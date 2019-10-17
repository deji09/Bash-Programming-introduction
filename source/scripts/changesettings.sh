#!/bin/bash
# Changes settings in configuaration files that can be set by the user

# Displays the current global settings to the user
displayCurrentSettings() {
    echo "Current global settings:"
    echo "Configuration file: $configPath"
    echo "Default editor: $editor"
    echo "Auto Update: $autoUpdate"
    echo
}

# Used to change a variable that is a string
changeStr() {
    echo
    # Stores the text to prompt the user with
    local displayString=$1
    # Stores the variable we are intending to change
    local variableToChange=$2
    # Stores the file we are changing
    local fileToChange=$3
    # Reads input from the user
    read -p "$displayString" input
    # Removes the current variable from the config
    grep -v "$variableToChange" $fileToChange > $fileToChange.tmp && mv $fileToChange.tmp $fileToChange
    # Adds the new variable to the file
    echo -e "$variableToChange=$input" >> $fileToChange
}

# Used to change a variable that is a boolean
changeBool() {
    echo
    # Stores the text to prompt the user with, if the variable
    # we are trying to change is currently true
    local displayStringIfTrue=$1
    # Same only if it's false
    local displayStringIfFalse=$2
    # Stores the variable we are intending to change
    local variableToChange=$3
    # Stores the file we are changing
    local fileToChange=$4
    # Loads the variables from the file we are changing
    source $fileToChange
    # If the current variable we are trying to change is true
    if [ "${!variableToChange}" == true ]; then
        # Asks the user to confirm to change the variable to false
        read -p "$displayStringIfTrue" yn
        case $yn in
            # If the user inputs something beginning with n, we do nothing
            [Nn]* )
                echo "No action taken"
            ;;
            # If the user enters any other input
            * )
                # Deletes the current value of the variable from the file
                grep -v "$variableToChange" $fileToChange > $fileToChange.tmp && mv $fileToChange.tmp $fileToChange
                # Adds the new variable to the file
                echo -e "$variableToChange=false" >> $fileToChange
            ;;
        esac
    else
        # Asks the user to confirm to change the variable to true
        read -p "$displayStringIfFalse" yn
        case $yn in
            # If the user inputs something beginning with n, we do nothing
            [Nn]* )
                echo "No action taken"
            ;;
            # If the user enters any other input
            * )
                # Deletes the current value of the variable from the file
                grep -v "$variableToChange" $fileToChange > $fileToChange.tmp && mv $fileToChange.tmp $fileToChange
                # Adds the new variable to the file
                echo -e "$variableToChange=true" >> $fileToChange
            ;;
        esac
    fi
}

# Used to change the name of a repository
repoName() {
    # Lists all the repositories
    source $trackproPath/scripts/listrepos.sh $repoPaths
    # Since we haven't found the repository yet
    found=false
    # Runs until we find the appropriate repository
    while [ "$found" == "false" ]; do
        # Reads input from the user
        read -p "What repository would you like to change the name of? " repoInput
        # Tries to find the repository of this name
        findRepo
        # Checks if we've found the repository
        if [ "$found" == "true" ]; then
            # Prompts the user for a new name and changes it
            changeStr "What do you want to change $name to be? " name $repoConfigPath
            # Prints a success message if the operations were successful
            if [ $? -eq 0 ]; then
                echo "Repository name has been successfully changed"
            fi
        else
            echo "Error: Repository name is invalid"
        fi
    done
}

# Allows the user to change the default editor
editor() {
    changeStr "New editor command: " editor $configPath
    # Prints a success message if the operations were successful
    if [ $? -eq 0 ]; then
        echo "Editor command has been successfully changed"
    fi
}


# Allows the user to change if a repository auto-compiles when a change is stored
autoCompile() {
    # Lists all the repositories
    source $trackproPath/scripts/listrepos.sh $repoPaths
    # Since we haven't found the repository yet
    found=false
    # Runs until we find the appropriate repository
    while [ "$found" == "false" ]; do
        # Reads input from the user
        read -p "What repository would you like to turn on/off automatic compilation? " repoInput
        # Tries to find the repository of this name
        findRepo
        # Checks if we've found the repository
        if [ "$found" == "true" ]; then
            # Enables/Disables automatic compilation
            changeBool "Would you like to turn off automatic compilation? [Y/n] " "Would you like to turn on automatic compilation? [Y/n] " makeOnStore $repoConfigPath
            # Prints a success message if the operations were successful
            if [ $? -eq 0 ]; then
                echo "Autocompile status has been successfully changed"
            fi
        else
            echo "Error: Repository name is invalid"
        fi
    done
}

# Displays the menu and processes the options available to the user
# Credits to askubuntu user Dennis Williamson
# Link: https://askubuntu.com/questions/1705/how-can-i-create-a-select-menu-in-a-shell-script
# Prints to the console
menu() {
    PS3='Please enter your choice: '
    # Defines the options for a user to select
    options=("Default editor" "Change repository name" "Enable/Disable automatic comilation" "Exit")
    # Allows the user to type in their prefered option
    select opt in "${options[@]}"
    do
        # Chooses the function based on the user's statement
        case $opt in
            "Default editor")
                # Allows the user to change the default editor
                editor
                break
            ;;
            "Change repository name")
                # Used to change the name of a repository
                repoName
                break
            ;;
            "Enable/Disable automatic comilation")
                # Allows the user to change if a repository auto-compiles when a change is stored
                autoCompile
                break
            ;;
            "Exit")
                break
            ;;
            *)
                # Prints what the user's typed
                echo "Error: Invalid Option $REPLY"
                echo "Please enter a valid option"
            ;;
        esac
    done
}

# Contains the main program
main() {
    absolutePath
    # Sets the path to the main trackpro configuration file as imported from the main script
    configPath=$1
    # Used to locate external scripts
    trackproPath=$2
    # Imports the variables from this configuration file
    source $configPath
    # Imports the findRepo method from an external script
    source $trackproPath/scripts/findrepo.sh
    # Displays the current settings
    displayCurrentSettings
    # Displays the menu and processes the options
    menu
}

# Runs the main program
main $1 $2