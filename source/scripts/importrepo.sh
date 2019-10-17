#!/bin/bash
# Imports a trackpro respository from a different computer

# Sets basic variables to be referenced to later in the script
setBasicVars() {
    targetInput=$1
    configPath=$2
    userPath=$3
}

# Adds the new repository to the main trackpro configuration file
editRepoPath() {
    # Removes the current configPath variable from the config
    grep -v "repoPaths" $configPath > $configPath.tmp && mv $configPath.tmp $configPath
    # Adds the new configPath variable to the file
    echo -e "repoPaths=($repoToImport $repoPaths)" >> $configPath
}

# Runs the main program
main() {
    # 
    repoToImport=$(readlink -f $targetInput)
    if [[ -e $repoToImport ]] && [[ -e $repoToImport/.trackpro/repo.conf ]] && [[ -e $repoToImport/.trackpro/changes.conf ]]; then
        editRepoPath
    fi
}

main $1 $2 $3
