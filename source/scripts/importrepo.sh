#!/bin/bash
# Imports a trackpro respository from a different computer

# Sets basic variables to be referenced to later in the script
setBasicVars() {
    # Stores the user's directory to import
    targetInput=$1
    # Stores the path to the trackpro configuration file
    configPath=$2
    # Stores the user's current path
    userPath=$3
}

# Adds the new repository to the main trackpro configuration file
editRepoPath() {
    # Stores the full path to the repo we are importing
    repoToImport=$(readlink -f $targetInput)
    # Removes the current configPath variable from the config
    grep -v "repoPaths" $configPath > $configPath.tmp && mv $configPath.tmp $configPath
    # Adds the new configPath variable to the file
    echo -e "repoPaths=($repoToImport $repoPaths)" >> $configPath
}

# Runs the main program to import a repository
main() {
    # Changes to the user's current directory
    cd $userPath
    # Sets basic variables used in other parts of the program
    setBasicVars $1 $2 $3
    # Checks if the folder we're trying to import exists
    if [[ -e $targetInput ]]; then
        # Checks if the folder we're trying to import has appropriate configuration files
        if [[ -e $targetInput/.trackpro/repo.conf ]]; then
            # Imports the repository
            editRepoPath
            # Prints a success message if the operations were successful
            if [ $? -eq 0 ]; then
                echo "Repository $targetInput has been successfully imported"
            fi
        else
            echo -e "Error: The directory $targetInput does not have appropriate configuration files.\nThis probably isn't already a trackpro repository, if you want to make it one then use the make option"
        fi
    else 
        echo "Error: The directory $targetInput does not exist"
    fi
}

# Runs the main program
main $1 $2 $3
