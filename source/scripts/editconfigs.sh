#!bin/bash
# Allows the user to edit configuration files in their set editor

# Opens the main configuration file with the default editor
mainConfig() {
    $editor $configPath
}

# Used to open the repository's configuration file with the default editor
repoConfig() {
    # Lists all the repositories
    source $trackproPath/scripts/listrepos.sh $repoPaths
    # Since we haven't found the repository yet
    found=false
    # Runs until we find the appropriate repository
    while [ "$found" == "false" ]; do
        # Reads input from the user
        read -p "What repository would you like to like to edit the config file of? " repoInput
        # Imports the findRepo method from an external script
        source $trackproPath/scripts/findrepo.sh
        # Tries to find the repository of this name
        findRepo
        # Checks if the name of this repository is the one we're trying to find
        if [ "$found" == "true" ]; then
            # Opens the repository's configuration file with the default editor
            $editor $repoConfigPath
        else
            echo "Repository name is invalid"
        fi
    done
}

# Credits to askubuntu user Dennis Williamson
# Link: https://askubuntu.com/questions/1705/how-can-i-create-a-select-menu-in-a-shell-script
# Displays the menu and processes the options available to the user
menu() {
    # Prints to the console
    PS3='Please enter your choice: '
    # Defines the options for a user to select
    options=("Main configuration" "Repository configuration" "Exit")
    # Allows the user to type in their preffered option
    select opt in "${options[@]}"
    do
        # Chooses the function based on the user's statement
        case $opt in
            "Main configuration")
                # Opens the main configuration file with the default editor
                mainConfig
                break
            ;;
            "Repository configuration")
                # Used to open the repository's configuration file with the default editor
                repoConfig
                break
            ;;
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
}

# Contains the main program
main() {
    # Sets the path to the main trackpro configuration file as imported from the main script
    configPath=$1
    # Used to locate external scripts
    trackproPath=$2
    # Imports the variables from this configuration file
    source $configPath
    # Displays the menu and processes the options
    menu
}

# Runs the main program
main $1 $2



