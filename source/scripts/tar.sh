#!/bin/bash
# Puts a version of a repository in a compressed file

target=$1 #path to target repo

copyRepo=($(cp -r $target archivedRepo)) # copys the repo needed

tar -cz copyRepo # archives it using tar command
tar -t copyRepo.tar # lists contents of the tar file
rm -r archivedRepo # deletes the copied repo