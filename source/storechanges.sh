#!/bin/bash
version=0.0


# Max Kelly's code
echo "Welcome to the file change tracker (version $version)"
# Interprets first argument

        echo filedifference
	# What are the files that you  would like to see their differences 
	
	# read -p 'file 1: ' file1 
	
	# read -p 'file 2: ' file2
	echo " What user is making this repository "
	read -p ' User: ' user1

	echo " This is  " $user1 " repository "
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


# Max Fyall's code


# Deji's code
