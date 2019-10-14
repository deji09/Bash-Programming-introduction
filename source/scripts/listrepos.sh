#!/bin/bash
#
repoPaths=$1

echo 
echo -e "Name\t\tPath"
for i in ${repoPaths[@]};
do
	echo -e "$name\t$i";
	source $i/.trackpro/repo.conf;
done