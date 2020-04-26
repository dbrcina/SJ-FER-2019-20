#!/bin/bash

dest=${!#}
if [ -f $dest ]; then
	echo "'$dest' is a file and program expects directory as a destination."
	exit 1
fi
if [ ! -d $dest ]; then
	mkdir -p $dest
	[ $? -eq 0 ] && echo "Directory '$dest' was created successfully."
fi

number_of_files=$(($#-1))
successfully_copied=0
for i in `seq 1 $number_of_files`
do
	file=${!i}
	[ ! -f $file ] && echo "'$file' is not a file." && continue
	[ ! -r $file ] && echo "'$file' is not readable." && continue
	
	cp $file $dest
	[ $? -eq 0 ] && echo "'$file' successfuly copied to '$dest'." && ((successfully_copied++))
done

echo "$successfully_copied files successfully copied into directory '$dest'."
