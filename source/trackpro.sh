#!/bin/bash
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
        echo displayhelp
        ;;
    -m | --makerepo)
        echo makerepo
        ;;
    -l | --listrepos)
        echo listrepos
        ;;
    -s | --storechanges)
        echo storechanges
        ;;
    -t | --tar)
        echo tar
        ;;
    -u | --undochange)
        echo undochange
        ;;
    *) ./scripts/help.sh;
esac

# Max Fyall's code


# Deji's code
