#!/bin/bash
# Help script to display a help guide

echo 
echo "Usage: trackpro [options] [target]"
echo "Options:"
echo -e " -a, --adduser\t\t Adds a user to the trackpro configuration file followed by the new user's name" 
echo -e " -b, --beuser\t\t Changes to the specified user" 
echo -e " -d, --displayusers\t Displays a list of the users in the trackpro configuration file" 
echo -e " -h, --help\t\t Displays this help screen" 
echo -e " -m, --makerepo\t\t Makes a trackpro repository" 
echo -e " -l, --listrepos\t Lists the trackpro repositories stored in the trackpro configuration file" 
echo -e " -s, --storechanges\t Stores changes of a trackpro repository" 
echo -e " -t, --tar\t\t Compresses a version of a trackpro repository" 
echo -e " -u, --undochange\t Undoes a change built into a trackpro repository" 
echo
echo "Target:"
echo -e " -a, -b, --adduser, --beuser\t\t\t\t\t User name"
echo -e " -m, -t, -u, --makerepo, --tar, --undochange\t\t\t Repository name"
echo -e " -s, --storechanges\t\t\t\t\t\t Repository name or all (to do so for all repositories)"
echo -e " -d, -h, -l, --displayusers, --help, --listrepos\t\t No target required"