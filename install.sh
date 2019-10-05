#!/bin/bash
echo "Welcome to the trackpro installer"
echo "With this installer there are two types of installation"
echo "For more information please read the README file on Github"
echo "Please select your preffered option:"

PS3='Please enter your choice: '
options=("Global" "Local" "Exit Installation")
select opt in "${options[@]}"
do
    case $opt in
        "Global")
            echo
            echo "Global"
            break
            ;;
        "Local")
            echo
            echo "Local"
            break
            ;;
        # "Option 3")
        #     echo "you chose choice $REPLY which is $opt"
        #     ;;
        "Exit Installation")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done

# 1) Global
#     echo global;
# 2) Local
#     echo local;