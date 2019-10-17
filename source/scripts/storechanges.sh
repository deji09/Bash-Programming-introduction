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

#
identifyLatestStore() {
    # Changes to the .trackpro directory which holds the records
    cd ./.trackpro
    pwd
    declare -a folders
    while IFS= read -r -d '' file; do
        folders+=($file)
    done < <(find . -type d -name "*" -print0)
    # echo "${folders[@]}"
    declare -i foldersLength=${#folders[@]}
    lateCut=`echo ${folders[$((foldersLength-1))]} | cut -c 3-`
    latestStore=./.trackpro/$lateCut
    cd $currentRepoPath
}

#
autoCompile() {
    # Loads in the variables from the repository's configuration file
    source ./.trackpro/repo.conf
    # If the user has set the repository to run make every time changes are stored and a makefile exists
    if [ "$makeOnStore" == "true" ] && [ -e ./makefile ]; then
        # Compiles using the makefile
        make
    fi
}

commit() {
    read -p 'Type yes or Y to commit your changes, type anything else to decline writing commits ' choice
    if [ "$choice" == "yes" ] || [ "$choice" == "Y" ]
    then
        echo "Please enter your  commits into the file:"
        read commits
        echo -e ":$user:$now:">>./.trackpro/commits.conf
        echo -e " [Commit Section] \n" $commits " \n [end] ">>./.trackpro/commits.conf
    fi
}

perFileStore() {
    # 
    file=$1
    # Adds the file to the changes configuration record
    echo -e ":$user:$time:$file:" >> ./.trackpro/changes.conf
    fileCut=`echo $file | cut -c 3-`
    latecut=`echo $latestStore | cut -c -22`
    if [ -e "$latecut/$fileCut" ]; then
        diff $latecut/$fileCut $file>>./.trackpro/$time/$fileCut
    else
        cp -p $file $latecut/$fileCut
    fi
}

#
store() {
    echo "Edits stored under " $user "'s username"
    #
    mkdir ./.trackpro/$time
    
    # Credits to stackexchange user Mikel
    # Link: https://unix.stackexchange.com/questions/9496/looping-through-files-with-spaces-in-the-names
    # Loops through every file in the repository excluding the .trackpro folder
    find . -type f -name "*" ! -path "./.trackpro/*" -print0 | while IFS= read -r -d '' file; do
        perFileStore $file
    done
}

#
main() {
    # Sets basic variables to be referenced to later in the script
    setBasicVars $1 $2
    # Changes into the repository
    cd $currentRepoPath
    # 
    identifyLatestStore
    autoCompile
    store
    # Restores the original IFS
    IFS=$OIFS
}

main $1 $2