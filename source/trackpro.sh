#!/bin/bash
# trackpro main script
version=0.0

# Changes to the absolute path of the script, makes importing other scripts easier
absolutePath() {
    # Stores the current path the user is in, this is used in methods to identify
    # paths the user has specified
    userPath=$(pwd)
    # Changes to the absolute path of the script
    trackproPath=`dirname "$0"`
    trackproPath=`( cd "$trackproPath" && pwd )`
}

# Sets the configuration path and imports its variables
setConfigAndLogPath() {
    # Sets variables for different potential configuration paths
    local localConfigPath=$HOME/.trackpro/trackpro.conf
    local globalConfigPath=/etc/trackpro.conf
    local sourceConfigPath=$trackproPath/config/trackpro.conf
    # If there's a local configuration file
    if [ -f "$localConfigPath" ]; then
        # Gets the variables from the configuration file
        source $localConfigPath
        # Sets the configuration path
        configPath=$localConfigPath
        # Sets the log path
        logPath=$HOME/.trackpro/trackpro.log
        # If there's a global configuration file
        elif [ -f "$globalConfigPath" ]; then
        # Gets the variables from the configuration file
        source $globalConfigPath
        # Sets the configuration path
        configPath=$globalConfigPath
        # Sets the log path
        logPath=/var/log/trackpro.log
        # If there's a local configuration file
        elif [ -f "$sourceConfigPath" ]; then
        # Gets the variables from the configuration file
        source $sourceConfigPath
        # Sets the configuration path
        configPath=$sourceConfigPath
        # Sets the log path
        logPath=$trackproPath/trackpro.log
        # If there's no configuration file found
    else
        echo "Error: No configuration file found"
    fi
}

# Used to get a repository's path from its name
getRepoPath() {
    # Goes to the user's path
    cd $userPath
    # Sets target to null if the target has not been set by the loop below
    # This happens if the repository doesn't exist in either the trackpro configuration
    # or as a path
    target=null
    # Loops through every known repository
    for i in ${repoPaths[@]}; do
        # Loads all the variables from the repository configuaration file
        source $i/.trackpro/repo.conf;
        # Checks if we've found the repository with the appropriate name
        if [ "$1" == "$name" ]; then
            # Stores the repository's path at target
            target=$i
            # Checks if the user has typed a path equivalent to a repository
            elif [ "$1" -ef "$i" ]; then
            # Stores the repository's path at target
            target=$i
        fi
    done
    # Changes back to the path of this script
    cd $trackproPath
}

# Interprets whether the user has put in an option argument
interpretOption() {
    # Stores the user's argument for the option as userArg
    userArg=$1
    # Checks if the user hasn't entered an argument at all
    if [ "$userArg" == "" ]; then
        echo "Error: Option argument required"
        # Displays the help screen
        source $trackproPath/scripts/help.sh;
    fi
}

# Interprets the target which will become the path to the user's repository
interpretTarget() {
    # Checks if a user has entered an argument for the target (repository name or path)
    if [ "$1" == "" ]; then
        target=null
    # Checks if the user wants to do something to all repositories
    elif [ "$1" == "all" ]; then
        target=all
    else
        # Sets a target based on finding the repository's name in its path
        getRepoPath $1
    fi
}

# Runs the user's desired option and starts up any appropriate external scripts
runOption() {
    # Stores the user's argument for the option as userArg
    userArg=$1
    # Stores the user's argument for the target as userTarget
    # As opposed to target this has not been interpreted by the program
    # which is useful for some methods
    userTarget=$2
    # Runs the appropriate option
    case "$userArg" in
        "-a" | "--access")
            # Allows the user to access a repository by changing into it
            source $trackproPath/scripts/accessfilerepo.sh $target
        ;;
        "-c" | "--changesettings")
            # Changes settings in configuaration files that can be set by the user
            source $trackproPath/scripts/changesettings.sh $configPath $trackproPath
        ;;
        "-e" | "--edit")
            # Allows the user to edit configuration files in their set editor
            source $trackproPath/scripts/editconfigs.sh $configPath $trackproPath
        ;;
        "-h" | "--help")
            # Help script to display a help guide
            source $trackproPath/scripts/help.sh;
        ;;
        "-i" | "--import")
            # Imports a trackpro respository from a different computer
            source $trackproPath/scripts/importrepo.sh $userTarget $configPath $userPath
        ;;
        "-m" | "--make")
            # Makes a trackpro repository
            source $trackproPath/scripts/makerepo.sh $userTarget $configPath $userPath $trackproPath;
        ;;
        "-l" | "--list")
            # Lists the trackpro repositories stored in the trackpro configuration file
            source $trackproPath/scripts/listrepos.sh $repoPaths;
        ;;
        "-p" | "--permissions")
            echo permissions
            source $trackproPath/scripts/changepermissions.sh $target;
        ;;
        "-s" | "--store")
            # Stores changes of a trackpro repository
            source $trackproPath/scripts/storechanges.sh $target $configPath;
        ;;
        "-t" | "--tar")
            # Compresses a version of a trackpro repository
            source $trackproPath/scripts/tar.sh $target $userPath;
        ;;
        "-u" | "--undo")
            # Undoes a change built into a trackpro repository
            source $trackproPath/scripts/undochange.sh $target $configPath;
        ;;
        "-v" | "--view")
            # Displays the list of all files within the repository recursively
            ls -R $target
        ;;
        * )
            # Displays an error message to the user 
            echo "Error: Option Argument $userArg is invalid"
            # Help script to display a help guide
            source $trackproPath/scripts/help.sh;
    esac
}

# Holds the main program, run on launch
main() {
    # Displays the welcome message
    echo "Welcome to trackpro (version $version)"
    # Changes to the absolute path of the script, makes importing other scripts easier
    absolutePath
    # Sets the configuration file and imports its variables and sets the log file
    setConfigAndLogPath
    # Checks the users first argument for correct syntax and to determine if there's likely
    # to be short or long input
    interpretOption $1
    # Interprets the target which will become the path to the user's repository
    interpretTarget $2
    # Runs the user's desired option and starts up any appropriate external scripts
    runOption $1 $2
}

# Runs the main program
main $1 $2