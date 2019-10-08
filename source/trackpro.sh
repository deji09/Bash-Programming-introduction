#!/bin/bash
# trackpro main script
version=0.0

# Max Kelly's code
echo "Welcome to trackpro (version $version)"

# Stores the current working directory
user_pwd=$(pwd)
# Changes to the absolute path of the script
script_path=`dirname "$0"`
script_path=`( cd "$script_path" && pwd )`

# Interprets first argument
case $1 in
    -a | --adduser)
        echo adduser
    ;;
    -b | --beuser)
        echo beuser
    ;;
    -d | --displayusers)
        echo displayusers
    ;;
    -h | --help)
        echo displayhelp;
        source $script_path/scripts/help.sh;
    ;;
    -m | --makerepo)
        echo makerepo
    ;;
    -l | --listrepos)
        echo listrepos
    ;;
    -s | --storechanges)
        echo storechanges
        source $script_path/scripts/storechanges.sh;
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
        source $script_path/scripts/help.sh;
esac
# Changes to the user's previous directory
cd $user_pwd

# Max Fyall's code


# Deji's code
#
