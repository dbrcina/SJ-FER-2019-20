#!/bin/bash

parentFolder=$1
extension=$2

echo "First argument: $parentFolder" && echo "Second argument: $extension"

lines=0
for folder in `find $parentFolder -type d`
do
	temp=0
	for file in `find $folder -maxdepth 1 -name $extension`
	do
		temp=$((temp + `wc -l $file | cut -d " " -f 1`))
	done
	printf "%b -> %d\n" $folder $temp
	lines=$((lines + temp))
done
echo "Total number of lines: $lines"
