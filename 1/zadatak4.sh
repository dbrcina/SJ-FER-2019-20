#!/bin/bash

src=$1;
dest=$2;

for file in `ls $src`
do
	file="$src/$file"
	date=`stat -c %y $file | cut -d " " -f 1`
	folder_by_month="$dest/`date -d $date +%Y-%m`"
	mkdir -p $folder_by_month
	mv $file $folder_by_month
done	
