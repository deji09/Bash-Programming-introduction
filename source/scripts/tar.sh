#!/bin/bash
# Puts a version of a repository in a compressed file

target=$1 #path to target repo

echo "Do you want to revert changes in this repository? (y/n)" # ask user if they want to revert the changes in the repo
read userInput # reads the input from the user

if [[ "$userInput"!="y" ]] || [[ "$userInput"!="n" ]]; then # check if the input is invalid
	
	echo "INVALID INPUT, Please try again" # output error message if input is invalid

else if [[ userInput==y ]]; then # check if the user wants to revert the changes

	copyRepo=$(cp -r ($target) archivedRepo) # copys the repo needed

	bash undochange.sh # call the undo changes method

	tar -cz copyRepo # archives it using tar command
	tar -t copyRepo.tar # lists contents of the tar file

	rm -r archivedRepo # deletes the copied repo

	else

		copyRepo=$(cp -r ($target) archivedRepo) # copys the repo needed

		tar -cz copyRepo # archives it using tar command
		tar -t copyRepo.tar # lists the contents of the tar file

		rm -r archivedRepo # deletes the copied repo

	fi

fi