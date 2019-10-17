#!/bin/bash

# Used to find the path from the appropriate repository
findRepo() {
    # Runs through all the repositories stored in the configuration file
    for i in ${repoPaths[@]}; do
        # Stores the path to a configuration file
        repoConfigPath=$i/.trackpro/repo.conf
        # Imports the variables from the current configuration file
        source $repoConfigPath
        # Checks if the name of this repository is the one we're trying to find
        if [ "$name" == "$repoInput" ]; then
            # Confirms we've found the repository
            found=true
            # Breaks the loop since we've found the repository we needed
            break;
        fi
    done
}