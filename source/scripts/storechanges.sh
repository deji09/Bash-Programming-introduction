#!/bin/bash
version=0.0
# Stores the name of the repository the user wants to access
target=$1
# Stores the locations of all the repositories
repoPaths=$2
# Stores the user being used
user="$(whoami)"
time=$(date +%s)

currentRepoPath=/home/ayodejishote/Desktop/trackpro/repo-scripts
# currentRepoPath=../repo-scripts
cd $currentRepoPath
#currentRepoPath=/home/max/Documents/Github/trackpro/repo-scripts

# echo "Welcome to the file change tracker (version $version)"

# echo filedifference
# What are the files that you  would like to see their differences

# read -p 'file 1: ' file1

# read -p 'file 2: ' file2
# echo " What user is making this repository "
# read -p ' User: ' user1


# echo "The files your checking are" eat "and" cow
# if [ -e $eat ] && [ -e $cow ]
# then
#     echo " These files  exist "
#     sort <eat>eat.sorted
#     sort <cow>cow.sorted
#     date> differences | comm -23 eat.sorted cow.sorted > differences
#     cat differences
# else
#     echo " These files dont exist "
# fi
identifyLatestStore() {
    pwd
    cd ./.trackpro
    local folders=$(ls -d -- */)
    declare -i foldersLength=${#folders[@]}
    # echo $foldersLength
    latestStore=./.trackpro/${folders[$((foldersLength-1))]}
    # echo $latestStore
}

Store() {
    cd $currentRepoPath
    echo "Edits stored under " $user "'s username"
    # Credits to stackexchange user Mikel
    # Link: https://unix.stackexchange.com/questions/9496/looping-through-files-with-spaces-in-the-names
    # Stores the current value of the internal field seperator
    OIFS="$IFS"
    # Uses the newline IFS to process files with spaces 
    IFS=$'\n'
    #
    mkdir ./.trackpro/$time
    # Loops through every file in the repository excluding the .trackpro folder
    find . -type f -name "*" ! -path "./.trackpro/*" -print0 | while IFS= read -r -d '' file; do
        # Adds the file to the changes configuration record
        echo -e ":$user:$time:$file:" >> ./.trackpro/changes.conf 
        fileCut=`echo $file | cut -c 3-`
        diff $latestStore/$fileCut $file> ./.trackpro/$time/$fileCut
    done
    # Resores the original IFS
    IFS="$OIFS"
}

identifyLatestStore
Store
