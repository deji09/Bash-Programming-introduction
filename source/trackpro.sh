#!/bin/bash
# trackpro main script
version=0.0

# Changes to the absolute path of the script
trackproPath=`dirname "$0"`
trackproPath=`( cd "$trackproPath" && pwd )`

# Sets the configuration path and imports its variables
setConfigPath() {
    local localConfigPath=$HOME/.trackpro
    local globalConfigPath=/etc/trackpro.conf
    local sourceConfigPath=$trackproPath/source/config/trackpro.conf
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
    -a | --adduser)
        echo adduser
        echo Liked deprecated
    ;;
    -b | --beuser)
        echo beuser
        echo Liked deprecated
    ;;
    -d | --displayusers)
        echo displayusers
    ;;
    -h | --help)
        echo displayhelp;
        source $trackproPath/scripts/help.sh;
    ;;
    -m | --makerepo)
        echo makerepo
        source $trackproPath/scripts/makerepo.sh $1 $configPath;
    ;;
    -l | --listrepos)
        echo listrepos $repoPaths
    ;;
    -s | --storechanges)
        echo storechanges
        source $trackproPath/scripts/storechanges.sh $1 $repoPaths;
    ;;
    -t | --tar)
        echo tar 
    ;;
    -u | --undochange)
        echo undochange
    ;;
    *)
        if [ "$1" != "" ]; then
            echo "Command '$1' unrecognized"
        else
            echo "Option argument required"
        fi
        source $trackproPath/scripts/help.sh;
esac