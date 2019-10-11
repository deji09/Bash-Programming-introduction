#!/bin/bash
version=0.0
# Stores the name of the repository the user wants to access
target=$1
# Stores the locations of all the repositories
repoPaths=$2
# Stores the user being used
user="$(whoami)"
#
currentRepoPath=../repo-example
#currentRepoPath=/home/max/Documents/Github/trackpro/repo-example

# echo "Welcome to the file change tracker (version $version)"

# echo filedifference
# What are the files that you  would like to see their differences

# read -p 'file 1: ' file1

# read -p 'file 2: ' file2
# echo " What user is making this repository "
# read -p ' User: ' user1

identifyLatestStore() {
    pwd
    cd $currentRepoPath/.trackpro
    local folders=$(ls -d -- */)
    declare -i foldersLength=${#folders[@]}
    echo $foldersLength
    latestStore=${distro[$((foldersLength-1))]}
    echo $latestStore
}

identifyLatestStore
echo "Edits stored under " $user "'s username"

echo "The files your checking are" eat "and" cow
if [ -e $eat ] && [ -e $cow ]
then
    echo " These files  exist "
    sort <eat>eat.sorted
    sort <cow>cow.sorted
    date> differences | comm -23 eat.sorted cow.sorted > differences
    cat differences
else
    echo " These files dont exist "
fi