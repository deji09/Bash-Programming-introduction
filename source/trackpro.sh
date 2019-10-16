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

# 
runOption() {
    # Stores the user's argument for the option as userArg
    userArg=$1
    # Stores the user's argument for the target as userTarget
    # As opposed to target this has not been interpreted by the program 
    # which is useful for some methods
    userTarget=$2
    case "$userArg" in
        "-a" | "--access")
            echo access
            source $trackproPath/scripts/accessfilerepo.sh $target
        ;;
        "-c" | "--changesettings")
            echo changesettings
            source $trackproPath/scripts/changesettings.sh $configPath
        ;;
        "-h" | "--help")
            echo help;
            source $trackproPath/scripts/help.sh;
        ;;
        "-i" | "--import")
            echo import
            source $trackproPath/scripts/importrepo.sh $userTarget $configPath $userPath
        ;;
        "-m" | "--make")
            echo make
            source $trackproPath/scripts/makerepo.sh $userTarget $configPath;
        ;;
        "-l" | "--list")
            echo list
            source $trackproPath/scripts/listrepos.sh $repoPaths;
        ;;
        "-s" | "--store")
            echo store
            source $trackproPath/scripts/storechanges.sh $target $repoPaths;
        ;;
        "-t" | "--tar")
            echo tar
            source $trackproPath/scripts/tar.sh $target $configPath;
        ;;
        "-u" | "--undo")
            echo undo
            source $trackproPath/scripts/undochange.sh $target $configPath;
        ;;
        "-v" | "--view")
            echo view
            ls -R $target
        ;;
        * )
            echo "Error: Option Argument $userArg is invalid"
            source $trackproPath/scripts/help.sh;
    esac
}

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
    runOption $1 $2
}

# Runs the main program
main $1 $2