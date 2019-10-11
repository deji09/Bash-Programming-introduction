#!/bin/bash
#
repoPaths=$1

echo 
echo -e "Name\t\tPath"
for i in ${repoPaths[@]};
do
	source $i/.trackpro/repo.conf;
	echo -e "$name\t$i";
done