#!/bin/bash
version=0.0

# Max Kelly's code
echo "Welcome to the file change tracker (version $version)"
declare -A my_array
# Interprets first argument

        echo filedifference
	# What are the files that you  would like to see their differences 
	
	read -p 'file 1: ' file1 
	
	read -p 'file 2: ' file2
	echo "The files your checking are $file1 and $file2"
	if [ -e $file1 ] && [ -e $file2 ]
	then
	echo " These files  exist " 
	else 
	echo " These files dont exist "
	fi


# Max Fyall's code


# Deji's code
