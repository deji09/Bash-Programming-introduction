#!/bin/bash
#
repoPaths=$1

for i in ${repoPaths[@]};
do
	echo $[i];
	source $repoPaths[i];/.trackpro/repo.conf;
	echo $name;
done