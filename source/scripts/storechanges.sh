#!/bin/bash
version=0.0
# Stores the location of the repository the user wants to access
currentRepoPath=$1
# Stores the locations of all the repositories
repoPaths=$2
# Stores the user being used
user="$(whoami)"
time=$(date +%s)
now=$(date)

# Changes into the repository
cd $currentRepoPath

setIFS() {
    # Credits to stackexchange user Mikel
    # Link: https://unix.stackexchange.com/questions/9496/looping-through-files-with-spaces-in-the-names
    # Stores the current value of the internal field seperator
    OIFS="$IFS"
    # Adds the time created to the repo's configuration file
    # Uses the newline IFS to process files with spaces
    IFS=$'\n'
}
# This stores the latest version of the file
identifyLatestStore() {
    cd ./.trackpro
    pwd
    declare -a folders

    while IFS= read -r -d '' file; do
        folders+=($file)
        # echo $file
        # echo "${folders[@]}"
    done < <(find . -type d -name "*" -print0)

    # echo "${folders[@]}"
    declare -i foldersLength=${#folders[@]}
    # echo $foldersLength
    lateCut=`echo ${folders[$((foldersLength-1))]} | cut -c 3-`
    latestStore=./.trackpro/$lateCut
}
# Method that stores the changes in a file
Store() {
    echo $currentRepoPath
    cd $currentRepoPath
    echo "Edits stored under " $user "'s username"
    mkdir ./.trackpro/$time
    read -p'Type yes or Y to commit your changes, type anything else to decline writing commits ' choice 
    if [ "$choice" == "yes" ] || [ "$choice" == "Y" ]
        then 
            echo "Please enter your  commits into the file:"
            read commits
            echo -e ":$user:$now:">>./.trackpro/Commits.conf
            echo -e " [Commit Section] \n" $commits " \n [end] ">>./.trackpro/Commits.conf
        fi
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
        # if the file is a new file then stores the changes for it too
            cp -p $file $latecut/$fileCut
        fi
    done
    rm 2changes.txt
    # Resores the original IFS
    IFS="$OIFS"
}

setIFS
identifyLatestStore
Store
IFS=$OIFS