#!/bin/bash

src=$1;
dest=$2;

for file in `ls $src`
do
	file="$src/$file"
	date=`stat -c %y $file | cut -d " " -f 1`
	folderByMonths="$dest/`date -d $date +%Y-%m`"
	mkdir -p $folderByMonths
	mv $file $folderByMonths
done	
