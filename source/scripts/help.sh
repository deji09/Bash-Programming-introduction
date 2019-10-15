#!/bin/bash
# Help script to display a help guide

echo
echo "Usage: trackpro [options] [target]"
echo "Options:"
echo -e " -a, --accessfilerepository\t "
echo -e " -c, --changesettings\t Used to change settings for each user, all users and for each repository"
echo -e " -h, --help\t\t Displays this help screen"
echo -e " -i, --importrepo\t Imports a trackpro respository from a different computer "
echo -e " -m, --makerepo\t\t Makes a trackpro repository"
echo -e " -l, --listrepos\t Lists the trackpro repositories stored in the trackpro configuration file"
echo -e " -s, --storechanges\t Stores changes of a trackpro repository"
echo -e " -t, --tar\t\t Compresses a version of a trackpro repository"
echo -e " -u, --undochange\t Undoes a change built into a trackpro repository"
echo -e " -v, --view\t Displays the list of all files within the repository recursively"
echo
echo "Target:"
echo -e " -a, -i, -m, -t, -u, -v, --accessfilerepository, --importrepo, --makerepo, --tar, --undochange\t\t Repository name or path"
echo -e " -s, --storechanges\t\t\t\t\t\t\t\t\t\t\t Repository name, path or all"
echo -e " -c, -h, -l, ---changesettings, --help, --listrepos\t\t\t\t\t\t\t No target required"