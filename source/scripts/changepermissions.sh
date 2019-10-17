#!/bin/bash
# changes the permissions of every file stored

target=$1

echo $target

if [[ "$target" == null ]]; then
	echo "Error: Invalid Input"
else
	echo "WARNING: Permissions will be changed for group and other, not user, for the repository and all files inside"
	echo "Do you wish to add or remove permissions? Enter A or R"
	read line

	if [[ "$line" == "a" ]] || [[ "$line" == "A" ]]; then

		echo "What permissions do you want to change in this repository?"
		echo "Read, Write or Execute (R|W|X)"
		read userInput

		if [[ "$userInput" == null ]]; then
			echo "Error: Invalid Input"
		fi

		if [[ "$userInput" == "W" ]] || [[ "usertInput" == "w" ]]; then
			chmod -r g+w $target
			chomd -r o+w $target
		fi

		if [[ "$userInput" == "R" ]] || [[ "$userInput" == "r" ]]; then
			chmod -r g+r $target
			chmod -r $target o+r
		fi

		if [[ "$userInput" == "X" ]] || [[ "$userInput" == "x" ]]; then
			chmod -r g+x $target
			chmod -r o+x $target
		fi
	fi

	if [[ "$line" == "r" ]] || [[ "$line" == "R" ]]; then

		echo "What permissions do you want to change in this repository?"
		echo "Read, Write or Execute (R|W|X)"
		read userInput2

		if [[ "$userInput2" == null ]]; then
			echo "Error: Invalid Input"
		fi

		if [[ "$userInput2" == "W" ]] || [[ "usertInput" == "w" ]]; then
			chmod -r g-w $target
			chmod -r o-w $target
		fi

		if [[ "$userInput2" == "R" ]] || [[ "$userInput" == "r" ]]; then
			chmod -r g-r $target
			chmod -r o-r $target
		fi

		if [[ "$userInput2" == "X" ]] || [[ "$userInput" == "x" ]]; then
			chmod -r g-x $target
			chmod -r o-x $target
		fi
	fi
fi

