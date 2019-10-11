#!/bin/bash
# Creates a repository
target=$1
configPath=$2

make() {
    if [ ! -d $target ]; then
        mkdir $target
    fi
    if [ ! -d $target/.trackpro ]; then
        mkdir -pv $target
        cd $target
        time=$(date +%s)
        mkdir -pv ./.trackpro/$time
        echo -e "name=$(basename $target)" >> ./.trackpro/repo.conf
        echo -e "created=$time"  >> ./.trackpro/repo.conf
        for entry in "$(ls)"; do
            echo -e ":$(whoami):$time:$entry:" >> ./.trackpro/changes.conf
            cp -pv $entry ./.trackpro/$time
        done

        # Edits the user's PATH at launch so the user can just type trackpro in every directory
        # echo -e "\nexport PATH=\"$installPath:\$PATH"\" >> $profilePath
        # Removes the current configPath variable from the config
        grep -v "repoPaths" $configPath > $configPath.tmp && mv $configPath.tmp $configPath
        # Adds the new configPath variable to the file
        echo -e "repoPaths=$input" >> $configPath
    else
        echo "Repository creation stopped: trackpro repository detected"
        # Credits to Stackoverflow user Myrddin Emrys
        # Link: https://stackoverflow.com/questions/226703/how-do-i-prompt-for-yes-no-cancel-input-in-a-linux-shell-script
        # Reads input from the user as yn
        read -p "Do you want to import this repository instead [Y/n] " yn
        case $yn in
            [Nn]* )
                ;;
            * )
                source importrepo.sh
                ;;
        esac
    fi
}

if [ "$target" == "null" ]; then
    echo "Error: Path required after option"
else
    # Credits to Stackoverflow user Myrddin Emrys
    # Link: https://stackoverflow.com/questions/226703/how-do-i-prompt-for-yes-no-cancel-input-in-a-linux-shell-script
    # Reads input from the user as yn
    read -p "Are you sure you want to create a repository at $target [Y/n] " yn
    # Doesn't make repo if the user enters an input beginning with a n
    # And makes repo otherwise
    case $yn in
        [Nn]* )
            ;;
        * )
            make
            ;;
    esac
fi