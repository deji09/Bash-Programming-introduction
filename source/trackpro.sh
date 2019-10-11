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
    local localConfigPath=$HOME/.trackpro/trackpro.conf
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
# 
if [ "$1" == "" ]; then
    echo "Error: Option argument required"
    source $trackproPath/scripts/help.sh;
fi
# 
if [ "$2" == "" ]; then
    target=null
else 
    target=$2
fi
# Interprets first argument
while getopts "chmlstu" opt; do
    case ${opt} in
        c )
            echo changesettings
            source $trackproPath/scripts/changesettings.sh $configPath
        ;;
        h )
            echo displayhelp;
            source $trackproPath/scripts/help.sh;
        ;;
        m )
            echo makerepo
            source $trackproPath/scripts/makerepo.sh $target $configPath;
        ;;
        l )
            echo listrepos $repoPaths
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
        * )
            source $trackproPath/scripts/help.sh;
    esac
done

