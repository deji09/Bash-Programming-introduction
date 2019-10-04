#!/bin/bash
version=0.0

# Max Kelly's code
echo "Welcome to trackpro (version $version)"

# Interprets arguments
case $1 in 
    -a | --adduser)
        echo adduser
        ;;
    -c | --createrepo)
        echo createrepo
        ;;
    -s | --storechanges)
        echo storechanges
        ;;
    *) ./scripts/help.sh;
esac

# Max Fyall's code


# Deji's code
