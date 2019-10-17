#!bin/bash
# Allows the user to access a repository by changing into it

# Sets the repository the user want to access as imported from the main script
target=$1
if [ -e $target ]; then
    # Changes into this repository
    cd $target
    # Lists all the files and folders in this repository using recursion
    ls -R $target
    # Starts a new shell, so the changed directory is applied
    exec $SHELL 
else 
    # Displays an error message
    echo "Error: Repository doesn't exist"
fi
