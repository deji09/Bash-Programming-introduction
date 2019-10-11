#!/bin/bash
# trackpro main script
version=0.0

# Variables to set user arguments for debugging
# $1 = -c

# Changes to the absolute path of the script
trackproPath=`dirname "$0"`
trackproPath=`( cd "$trackproPath" && pwd )`

# Sets the configuration path and imports its variables
setConfigPath() {
    local localConfigPath=$HOME/.trackpro
    local globalConfigPath=/etc/trackpro.conf
    local sourceConfigPath=$trackproPath/config/trackpro.conf
    # If there's a local configuration file import it
    if [ -f "$localConfigPath" ]; then
        # Gets the variables from the configuration file
        source $localConfigPath
        # Sets the configuration path
        configPath=$localConfigPath
    elif [ -f "$globalConfigPath" ]; then
        source $globalConfigPath
        configPath=$globalConfigPath
    elif [ -f "$sourceConfigPath" ]; then
        source $sourceConfigPath
        configPath=$sourceConfigPath
    else 
        echo "Error: No valid configuration file found"
    fi
}

# Displays the welcome message
echo "Welcome to trackpro (version $version)"
# Sets the configuration file and imports its variables
setConfigPath
# Interprets first argument
case $1 in
    -c | --changesettings)
        echo changesettings
        source $trackproPath/scripts/changesettings.sh $configPath
    ;;
    -h | --help)
        echo displayhelp;
        source $trackproPath/scripts/help.sh;
    ;;
    -m | --makerepo)
        echo makerepo
        source $trackproPath/scripts/makerepo.sh $2 $configPath;
    ;;
    -l | --listrepos)
        echo listrepos $repoPaths
        source $trackproPath/scripts/listrepos.sh $repoPaths;
    ;;
    -s | --storechanges)
        echo storechanges
        source $trackproPath/scripts/storechanges.sh $2 $repoPaths;
    ;;
    -t | --tar)
        echo tar 
        source $trackproPath/scripts/tar.sh $2 $configPath;
    ;;
    -u | --undochange)
        echo undochange
        source $trackproPath/scripts/undochange.sh $2 $configPath;
    ;;
    *)
        if [ "$1" != "" ]; then
            echo "Command '$1' unrecognized"
        else
            echo "Option argument required"
        fi
        source $trackproPath/scripts/help.sh;
esac