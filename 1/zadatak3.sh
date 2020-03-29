#!/bin/bash

log_files=`ls | grep -iE "^.*_log\.[0-9]{4}-[0-9]{2}-[0-9]{2}.txt$"`
for log_file in $log_files
do
	date=`echo $log_file | cut -d "." -f 2`

	#skip everything besides February
	[ `date -d $date +%m` != 02 ] && continue

	echo "datum: `date -d $date +%d-%m-%Y`"
	echo "-------------------------------------------------------"
	cut -d '"' -f 2 $log_file | sort | uniq -c | sort -nr
done
