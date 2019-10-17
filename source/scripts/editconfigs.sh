#!bin/bash
# Allows the user to edit configuration files in their set editor

mainConfig() {
    $editor $configPath
}

repoConfig() {
    # 
    source $trackproPath/scripts/listrepos.sh $repoPaths
    #
    found=false
    #
    while [ "$found" == "false" ]; do
        # Reads input from the user
        read -p "What repository would you like to like to edit the config file of? " repoInput
        #
        for i in ${repoPaths[@]}; do
            repoConfigPath=$i/.trackpro/repo.conf
            source $repoConfigPath
            if [ "$name" == "$repoInput" ]; then
                found=true
                break;
            fi
        done
        if [ "$found" == "true" ]; then
            $editor $repoConfigPath
        else
            echo "Repository name is invalid"
        fi
    done
}

configPath=$1
trackproPath=$2
source $configPath

# Credits to askubuntu user Dennis Williamson
# Link: https://askubuntu.com/questions/1705/how-can-i-create-a-select-menu-in-a-shell-script
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
            mainConfig
            break
        ;;
        "Repository configuration")
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
