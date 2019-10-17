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
# This is the method that stores the latest file into the variable latest store
identifyLatestStore() {
    cd ./.trackpro
    pwd
    # Creates an array called folders
    declare -a folders
    # While loop that inserts elements into the array
    while IFS= read -r -d '' file; do
        folders+=($file)
    done < <(find . -type d -name "*" -print0)
    # Creates an array that stores the folder length 
    declare -i foldersLength=${#folders[@]}
    # Stores the last element of the array into a folder
    lateCut=`echo ${folders[$((foldersLength-1))]} | cut -c 3-`
    latestStore=./.trackpro/$lateCut
}
# This is the method that undo's any changes
Undo()
{
    # this tells the user the current repository path
    echo $currentRepoPath
    cd $currentRepoPath
    echo " You are currently in users" $user "'s directory"
    ls
    read -p'What is the file that you would like to undo the changes ' choice
    # Cuts the latestStore variable so it doesnt have the ./ in front of it
    latecut=`echo $latestStore | cut -c -3`
    # Checks if the file you want to revert the changes for exists.
    if [ -e $choice ] && [ -e ./.trackpro/$lateCut/$choice ]
    then
    # Copies the value of the previous file storage into the new file
    cp ./.trackpro/$lateCut/$choice $choice
    echo "The changes to the file " $choice " have been reverted."
    else
    # This displays the message that the file doesnt exist.
    echo $choice "does not exist , Or it doesn't have a saved version please. "
    fi
}


setIFS
identifyLatestStore
Undo