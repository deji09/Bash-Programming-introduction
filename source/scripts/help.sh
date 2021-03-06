#!/bin/bash
# Help script to display a help guide

echo
echo "Usage: trackpro [options] [target]"
echo "Options:"
echo -e " -a, --access\t\t Changes the terminal's directory"
echo -e " -c, --changesettings\t Used to change settings for each user, all users and for each repository"
echo -e " -e, --edit\t\t Allows the user to edit trackpro configuration files"
echo -e " -h, --help\t\t Displays this help screen"
echo -e " -i, --import\t\t Imports a trackpro respository from a different computer "
echo -e " -m, --make\t\t Makes a trackpro repository"
echo -e " -l, --list\t\t Lists the trackpro repositories stored in the trackpro configuration file"
echo -e " -s, --store\t\t Stores changes of a trackpro repository"
echo -e " -t, --tar\t\t Compresses a version of a trackpro repository"
echo -e " -u, --undo\t\t Undoes a change built into a trackpro repository"
echo -e " -v, --view\t\t Displays the list of all files within the repository recursively"
echo
echo "Target:"
echo -e " -a, -i, -m, -s, -t, -u, -v, --access, --import, --make, --store, --tar, --undo\t Repository name or path"
echo -e " -c, -e, -h, -l, ---changesettings, --edit, --help, --list\t\t No target required"