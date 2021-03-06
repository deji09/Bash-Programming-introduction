#!/bin/bash
# Stores changes of a trackpro repository

# Sets basic variables to be referenced to later in the script
setBasicVars() {
    # Stores the location of the repository the user wants to access
    currentRepoPath=$1
    # Stores the locations of all the repositories
    configPath=$2
    # Stores the user being used
    user="$(whoami)"
    # Stores the current date and time in Unixtime
    time=$(date +%s)
    # Stores the current date and time in a human readable form
    now=$(date)
    # Stores the current value of the internal field seperator
    OIFS="$IFS"
    # Adds the time created to the repo's configuration file
    # Uses the newline IFS to process files with spaces
    IFS=$'\n'
}
# This stores the latest version of the file
identifyLatestStore() {
    # Changes to the .trackpro directory which holds the records
    cd ./.trackpro
    # Creates an array to store all the folders in the .trackpro folder
    declare -a folders
    # Loops through all the folders
    while IFS= read -r -d '' folder; do
        # Appends the current folder to the array
        folders+=($folder)
        # Gets the name of the current folder
    done < <(find . -type d -name "*" -print0)
    # Stores how many folders that have been found
    declare -i foldersLength=${#folders[@]}
    # Cuts off the first two characters which are ./ as they prevent us from creating other directories
    lateCut=`echo ${folders[$((foldersLength-1))]} | cut -c 3-`
    # Stores the path to the folder with the latest changes
    latestStore=./.trackpro/$lateCut
    # Changes back into the main repository
    cd $currentRepoPath
}

# Autocompiles code if a
autoCompile() {
    # Loads in the variables from the repository's configuration file
    source ./.trackpro/repo.conf
    # If the user has set the repository to run make every time changes are stored and a makefile exists
    if [ "$makeOnStore" == "true" ] && [ -e ./makefile ]; then
        # Compiles using the makefile
        make
    fi
}

# Method that stores the changes in a file
store() {
    echo $currentRepoPath
    cd $currentRepoPath
    echo "Edits stored under " $user "'s username"
    mkdir ./.trackpro/$time
    # Takes in the user input of if they want commits or not
    read -p'Commit your changes, type anything else to decline writing commits [N/y]' choice
    # This takes in the user choice 
    case $choice in
        [Yy]* )
        # Puts in the commits into the commits file
            echo "Please enter your  commits into the file:"
            read commits
            echo -e ":$user:$now:">>./.trackpro/Commits.conf
            echo -e " [Commit Section] \n" $commits " \n [end] ">>./.trackpro/Commits.conf
        ;;
        * )
            echo "No commit added"
        ;;
    esac
    
    # Credits to stackexchange user Mikel
    # Link: https://unix.stackexchange.com/questions/9496/looping-through-files-with-spaces-in-the-names
    # Loops through every file in the repository excluding the .trackpro folder
    find . -type f -name "*" ! -path "./.trackpro/*" -print0 | while IFS= read -r -d '' file; do
        # Adds the file to the changes configuration record
        echo -e ":$user:$time:$file:" >> ./.trackpro/changes.conf
        fileCut=`echo $file | cut -c 3-`
        latecut=`echo $latestStore | cut -c 3-`
        if [ -e "$latecut/$fileCut" ]; then
            # Removes the symbols > and < in the diff method
            diff $latecut/$fileCut $file | grep '^[>* ]'| sed '/^[[:space:]]*$/d'>>./.trackpro/$time/$fileCut
            touch 2changes.txt
            sed 's/>//' ./.trackpro/$time/$fileCut>>2changes.txt
            cp 2changes.txt ./.trackpro/$time/$fileCut
            rm 2changes.txt
        else
            # if the file is a new file then stores the current version as the original version
            cp -p $file ./.trackpro/$time
        fi
    done
    # Resores the original IFS
    IFS="$OIFS"
}

#
main() {
    # Sets basic variables to be referenced to later in the script
    setBasicVars $1 $2
    # Changes into the repository
    if [ "$currentRepoPath" == "null" ] 
    then
    echo "This file path does not exist"
    echo "To use this method you can import the repository using the -i command or make one using the -m command."
    else
    cd $currentRepoPath
    #
    identifyLatestStore
    autoCompile
    store
    # Restores the original IFS
    IFS=$OIFS
    fi
}

main $1 $2