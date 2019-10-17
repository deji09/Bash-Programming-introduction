#!/bin/bash
# Creates a repository

# Stores the repository name or path we are trying to create
target=$1
# Stores the location of the trackpro configuration file
configPath=$2

# Setups the repository configuration
setupConfig() {
    # Creates a trackpro configuration folder
    mkdir -pv $target/.trackpro
    # Changes into the new repository
    cd $target
    # Stores the time at present in Unix time
    time=$(date +%s)
    # Creates a directory with time as the name
    mkdir -pv ./.trackpro/$time
    # Adds the repository name to the repo's configuration file
    echo -e "name=$(basename $target)" >> ./.trackpro/repo.conf
    # Adds the time created to the repo's configuration file
    echo -e "created=$time"  >> ./.trackpro/repo.conf
    
    
}

# Stores the changes of all the non-trackpro related files as an initial record
initialRecord() {
    # Credits to stackexchange user Mikel
    # Link: https://unix.stackexchange.com/questions/9496/looping-through-files-with-spaces-in-the-names
    # Stores the current value of the internal field seperator to help to deal with file names that have spaces.
    OIFS="$IFS"
    # Uses the newline IFS to process files with spaces 
    IFS=$'\n'
    # Loops through every file in the repository excluding the .trackpro folder
    find . -type f -name "*" ! -path "./.trackpro/*" -print0 | while IFS= read -r -d '' file; do
        # Adds the file to the changes configuration record
        echo -e ":$(whoami):$time:$file:" >> ./.trackpro/changes.conf
        # Copies the file as a backup as an initial source
        cp -pv $file ./.trackpro/$time
    done
    # Resores the original IFS
    IFS="$OIFS"
}

# Adds the new repository to the main trackpro configuration file
editRepoPath() {
    # Removes the current configPath variable from the config
    grep -v "repoPaths" $configPath > $configPath.tmp && mv $configPath.tmp $configPath
    # Adds the new configPath variable to the file
    echo -e "repoPaths=($(pwd) $repoPaths)" >> $configPath
}

# Asks the user if they'd like to import this repository instead
considerImport() {
    # Asks the user if they want to import this directory instead
    echo "Repository creation stopped: trackpro repository detected"
    # Reads input from the user as yn
    read -p "Do you want to import this repository instead [Y/n] " yn
    case $yn in
        [Nn]* )
        ;;
        * )
            source importrepo.sh
        ;;
    esac
}

# Makes a repository
make() {
    # Checks if a folder doesn't exist where there's a repository we want to create
    if [ ! -d $target ]; then
        # Makes the repository folder
        mkdir -pv $target
    fi
    # Checks if a trackpro configuration folder doesn't exist in the target
    if [ ! -d $target/.trackpro ]; then
        setupConfig
        initialRecord
        editRepoPath
    else
        considerImport
    fi
}

# Checks if the user has entered a target
if [ "$target" == "null" ]; then
    echo "Error: Path required after option"
else
    # Reads input from the user as yn
    read -p "Are you sure you want to create a repository at $target [Y/n] " yn
    case $yn in
        # Doesn't make the repo if the user enters an input beginning with a n
        [Nn]* )
        ;;
        # Makes the repository if the user enters anything else
        * )
            # Makes a repository
            make
        ;;
    esac
fi