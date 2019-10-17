#!/bin/bash
# changes the permissions of every file stored
# NOT IMPLEMENTED

target=$1 # gets the repo user wants to edit permissions

repoName=$(basename $target) # get the name of the repo from the file path

if [[ "$target" == null ]]; then # check if the user has not entererd a repo to edit
	echo "Error: Invalid Input" # output an error message if true
else
	echo "WARNING: Permissions will be changed for group and other, not user, for the repository and all files inside" # warning message
	echo "Do you wish to add or remove permissions? Enter A or R" # does user wish to add permissions or remove them from a repo
	read line # get user input

	if [[ "$line" == "a" ]] || [[ "$line" == "A" ]]; then # check if the user wants to add permissions

		echo "What permissions do you want to change in this repository?" # asks the user what permissions they want to add, read, write or execute
		echo "Read, Write or Execute (R|W|X)"
		read userInput # get input from user

		if [[ "$userInput" == null ]]; then # checks if user input is valid
			echo "Error: Invalid Input" # output error message
		fi

		if [[ "$userInput" == "W" ]] || [[ "usertInput" == "w" ]]; then # if user wants to add write permissions
			chmod -r g+w $target # add write permissions to group
			chomd -r o+w $target # add write permissions to other
		fi

		if [[ "$userInput" == "R" ]] || [[ "$userInput" == "r" ]]; then # if user wants to add read permissions
			chmod -r g+r $target # add read permissions to group
			chmod -r o+r $target # add read permissions to other
		fi

		if [[ "$userInput" == "X" ]] || [[ "$userInput" == "x" ]]; then # if user wants to add execute permissions
			chmod -r g+x $target # add execute permissions to group
			chmod -r o+x $target # add execute permissions to other
		fi
	fi

	if [[ "$line" == "r" ]] || [[ "$line" == "R" ]]; then # checks if the user wants to remove permissions

		echo "What permissions do you want to change in this repository?" # asks the user what permissions they want to remove, read, write or execute
		echo "Read, Write or Execute (R|W|X)"
		read userInput2 # get input from the user

		if [[ "$userInput2" == null ]]; then # checks if user input is valid
			echo "Error: Invalid Input" # prints error message
		fi

		if [[ "$userInput2" == "W" ]] || [[ "usertInput" == "w" ]]; then # if user wants to remove write permissions
			chmod -r g-w $target # remove write permissions from group
			chmod -r o-w $target # remove write permissions from other
		fi

		if [[ "$userInput2" == "R" ]] || [[ "$userInput" == "r" ]]; then # if user wants to remove read permissions
			chmod -r g-r $target # remove read permissions from group
			chmod -r o-r $target # remove read permissions from other
		fi

		if [[ "$userInput2" == "X" ]] || [[ "$userInput" == "x" ]]; then # if user wants to remove execute permissions
			chmod -r g-x $target # remove execute permissions from group
			chmod -r o-x $target # remove execute permissions from other
		fi
	fi
fi

