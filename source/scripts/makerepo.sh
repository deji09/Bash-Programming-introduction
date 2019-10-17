#!/bin/bash
# Creates a repository

# Sets basic variables to be referenced to later in the script
setBasicVars() {
    # Stores the user's directory to import
    targetInput=$1
    # Stores the path to the trackpro configuration file
    configPath=$2
    # Stores the user's current path
    userPath=$3
    #
    trackproPath=$4
    # Stores the user's new repository directory
    newRepoPath=$userPath/$targetInput
    echo $newPath
}

# Setups the repository configuration
setupConfig() {
    # Changes to the user's path
    cd $newRepoPath
    # Creates a trackpro configuration folder
    mkdir -pv $newRepoPath/.trackpro
    # Stores the time at present in Unix time
    time=$(date +%s)
    # Creates a directory with time as the name
    mkdir -pv $newRepoPath/.trackpro/$time
    # Adds the repository name to the repo's configuration file
    echo -e "name=$(basename $targetInput)" >> $newRepoPath/.trackpro/repo.conf
    # Adds the time created to the repo's configuration file
    echo -e "created=$time"  >> $newRepoPath/.trackpro/repo.conf
}

# Stores the changes of all the non-trackpro related files as an initial record
# Credits to stackexchange user Mikel
# Link: https://unix.stackexchange.com/questions/9496/looping-through-files-with-spaces-in-the-names
initialRecord() {
    # Stores the current value of the internal field seperator to help to deal with file names that have spaces.
    OIFS="$IFS"
    # Uses the newline IFS to process files with spaces
    IFS=$'\n'
    # Loops through every file in the repository excluding the .trackpro folder
    find . -type f -name "*" ! -path "./.trackpro/*" -print0 | while IFS= read -r -d '' file; do
        # Cuts of the ./ from the command
        file=`echo $file | cut -c 3-`
        # Gets a relative name as a failed attempt to get directories working
        file=$(realpath --relative-to="$newRepoPath" "$file")
        # Adds the file to the changes configuration record
        echo -e ":$(whoami):$time:$file:" >> $newRepoPath/.trackpro/changes.conf
        # Copies the file as a backup as an initial source
        cp -rpv $file $newRepoPath/.trackpro/$time
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

# Asks the user if they'd like to import this repository instead and if so does that
considerImport() {
    # Asks the user if they want to import this directory instead
    echo "Repository creation stopped: trackpro repository detected"
    read -p "Do you want to import this repository instead [Y/n] " yn
    case $yn in
        # If the user inputs something beginning with n, we do nothing
        [Nn]* )
            echo "No action taken"
        ;;
        # If the user enters any other input
        * )
            # Runs the import repo script to import this repository
            source importrepo.sh
        ;;
    esac
}

# Makes a repository
make() {
    # Checks if a folder doesn't exist where there's a repository we want to create
    if [ ! -d $targetInput ]; then
        # Makes the repository folder
        mkdir -pv $targetInput
    fi
    # Checks if a trackpro configuration folder doesn't exist in the target
    if [ ! -d $targetInput/.trackpro ]; then
        # Setups the repository configuration
        setupConfig
        # Stores the changes of all the non-trackpro related files as an initial record
        initialRecord
        # Adds the new repository to the main trackpro configuration file
        editRepoPath
    else
        # Asks the user if they'd like to import this repository instead and if so does that
        considerImport
    fi
}

# Contains the main program
main () {
    # Sets basic variables to be referenced to later in the script
    setBasicVars $1 $2 $3 $4
    # Checks if the user has entered a target
    if [ "$targetInput" == "null" ]; then
        echo "Error: Path required after option"
    else
        # Reads input from the user as yn
        read -p "Are you sure you want to create a repository at $targetInput [Y/n] " yn
        case $yn in
            # Doesn't make the repo if the user enters an input beginning with a n
            [Nn]* )
                break
            ;;
            # Makes the repository if the user enters anything else
            * )
                make
            ;;
        esac
    fi
}

# Runs the main program
main $1 $2 $3 $4