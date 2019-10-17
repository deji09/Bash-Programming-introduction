#!/bin/bash
# Puts a version of a repository in a compressed file

target=$1 #path to target repo
trackproPath=$2 # path to the destination of the archived repo

repoName=$(basename $target) # get the name of the repository

cp -r $target $trackproPath # copys the repo needed

echo "Your compressed repository contains:"

tar -czf archivedRepo.tar.gz $repoName # archives it using tar command
tar -tf archivedRepo.tar.gz # lists contents of the tar file
rm -r $repoName # deletes the copied repo