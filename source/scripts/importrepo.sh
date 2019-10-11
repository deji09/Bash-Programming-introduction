#!/bin/bash


# Adds the new repository to the main trackpro configuration file
editRepoPath() {
    # Removes the current configPath variable from the config
    grep -v "repoPaths" $configPath > $configPath.tmp && mv $configPath.tmp $configPath
    # Adds the new configPath variable to the file
    echo -e "repoPaths=($(pwd) $repoPaths)" >> $configPath
}