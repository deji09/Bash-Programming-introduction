#!/bin/bash
# Puts a version of a repository in a compressed file

target=$1 # path to target repo
userPath=$2 # the user's current path

if [[ "$target" == "null" ]]; then # check if the repo user aims to compress is null
	echo "Error: Invalid Input" # if so then print an error code
else # if not then continue witht the method
	repoName=$(basename $target) # get the name of the repository

	cp -r $target $repoName # copys the repo needed

	echo "Your compressed repository contains:" # print message

	tar -czf archivedRepo.tar.gz $repoName # archives it using tar command
	tar -tf archivedRepo.tar.gz # lists contents of the tar file
	mv archivedRepo.tar.gz $userPath # Moves the tar file to the user's current directory
	rm -r $repoName # deletes the copied repos
fi