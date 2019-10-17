#!/bin/bash
# Puts a version of a repository in a compressed file

target=$1 # path to target repo

repoName=$(basename $target) # get the name of the repository

cp -r $target $repoName # copys the repo needed

echo "Your compressed repository contains:" # print message

tar -czf archivedRepo.tar.gz $repoName # archives it using tar command
tar -tf archivedRepo.tar.gz # lists contents of the tar file
rm -r $repoName # deletes the copied repos