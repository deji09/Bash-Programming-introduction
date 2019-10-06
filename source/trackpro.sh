#!/bin/bash
# trackpro main script 
version=0.0

# Max Kelly's code
echo "Welcome to trackpro (version $version)"

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
        source ./trakcpro-scripts/help.sh;
        ;;
    -m | --makerepo)
        echo makerepo
        ;;
    -l | --listrepos)
        echo listrepos
        ;;
    -s | --storechanges)
        echo storechanges
        source ./scripts/storechanges.sh;
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
        ./scripts/help.sh;
esac

# Max Fyall's code


# Deji's code
# 
