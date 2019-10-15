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
cd $currentRepoPath