#!/bin/bash
# trackpro main script
version=0.0

# Variables to set user arguments for debugging
# $1 = -c

# Changes to the absolute path of the script, makes importing other scripts easier
absolutePath() {
    # Stores the current path the user is in
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
    elif [ -f "$globalConfigPath" ]; then
        source $globalConfigPath
        configPath=$globalConfigPath
        logPath=/var/log/trackpro.log
    elif [ -f "$sourceConfigPath" ]; then
        source $sourceConfigPath
        configPath=$sourceConfigPath
        logPath=$trackproPath/trackpro.log
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

# Interprets whether the user has put in a short form or long form argument
interpretOption() {
    # Checks if the user hasn't entered an argument at all
    if [ "$1" == "" ]; then
        echo "Error: Option argument required"
        # Displays the help screen
        source $trackproPath/scripts/help.sh;
    # Checks if the user has entered a long form argument and sets variables appropriately
    elif [[ "$1" == *"--"* ]]; then
        short=false
        long=true
    # Checks if the user has entered a short form argument and sets variables appropriately
    elif [[ "$1" == *"-"* ]]; then
        short=true
        long=false
    # Otherwise will set both variables to false
    else
        short=false
        long=false
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

# Interprets first longform argument
longForm() {
    case "$1" in
        "--accessfilerepo")
            echo accessfilerepo
            source $trackproPath/scripts/accessfilerepo.sh $target
        ;;
        "--changesettings")
            echo changesettings
            source $trackproPath/scripts/changesettings.sh $configPath
        ;;
        "--displayhelp")
            echo displayhelp;
            source $trackproPath/scripts/help.sh;
        ;;
        "--importrepo" )
            echo importrepo
            source $trackproPath/scripts/importrepo.sh $2 $configPath $userPath
        ;;
        "--makerepo")
            echo makerepo
            source $trackproPath/scripts/makerepo.sh $2 $configPath;
        ;;
        "--listrepos")
            echo listrepos
            source $trackproPath/scripts/listrepos.sh $repoPaths;
        ;;
        "--storechanges")
            echo storechanges
            source $trackproPath/scripts/storechanges.sh $target $repoPaths;
        ;;
        "--tar")
            echo tar
            source $trackproPath/scripts/tar.sh $target $configPath;
        ;;
        "--undochange")
            echo undochange
            source $trackproPath/scripts/undochange.sh $target $configPath;
        ;;
        "--view")
            echo view
            ls -R $target
        ;;
        * )
            echo "Error: illegal option -$1"
            source $trackproPath/scripts/help.sh;
    esac
}

# Interprets first shorthand argument
shortForm() {
    # Used to automatically interpret arguments
    while getopts "achimlstuv" opt; do
        case ${opt} in
            a )
                echo accessfilerepo
                source $trackproPath/scripts/accessfilerepo.sh $target
            ;;
            c )
                echo changesettings
                source $trackproPath/scripts/changesettings.sh $configPath
            ;;
            h )
                echo displayhelp;
                source $trackproPath/scripts/help.sh;
            ;;
            i )
                echo importrepo
                source $trackproPath/scripts/importrepo.sh $2 $configPath $userPath
            ;;
            m )
                echo makerepo
                source $trackproPath/scripts/makerepo.sh $2 $configPath;
            ;;
            l )
                echo listrepos
                source $trackproPath/scripts/listrepos.sh $repoPaths;
            ;;
            s )
                echo storechanges
                source $trackproPath/scripts/storechanges.sh $target $repoPaths;
            ;;
            t )
                echo tar
                source $trackproPath/scripts/tar.sh $target $configPath;
            ;;
            u )
                echo undochange
                source $trackproPath/scripts/undochange.sh $target $configPath;
            ;;
            v )
                echo view
                ls -R $target
            ;;
            * )
                source $trackproPath/scripts/help.sh;
        esac
    done
}

main() {
    # Displays the welcome message
    echo "Welcome to trackpro (version $version)"
    # Changes to the absolute path of the script, makes importing other scripts easier
    absolutePath
    setConfigAndLogPath
    # Sets the configuration file and imports its variables and sets the log file
    # Checks the users first argument for correct syntax and to determine if there's likely
    interpretOption $1 
    # to be short or long input
    # Interprets the target which will become the path to the user's repository
    interpretTarget $2
    if [ "$long" == "true" ]; then
        # Interprets the user's long form argument
        longForm $1 $2
    elif [ "$short" == "true" ]; then
        # Interprets the user's short form argument
        shortForm $1 $2
    else
        echo "Error: illegal option -$1"
        # Displays the help file
        source $trackproPath/scripts/help.sh;
    fi
}

# Runs the main program
main $1 $2