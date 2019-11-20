#!/bin/bash
# Lists the trackpro repositories stored in the trackpro configuration file

# Stores the repositories from the trackpro configuration file
repoPaths=$1

# [ "$repoPaths" -eq 0 ]
if [ "$repoPaths" == "-l" ] || [ "$repoPaths" == "--list" ]; then
    echo "Error: No repositories to list"
else
    echo
    echo -e "Name\t\tPath"
    
    # Loops through each repository
    for i in ${repoPaths[@]};
    do
        # Imports the variables from the configuration file
        source $i/.trackpro/repo.conf;
        # Prints each repository's name and path
        echo -e "$name\t$i";
    done
fi