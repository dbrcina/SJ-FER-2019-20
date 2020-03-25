#!/bin/bash

logFiles=`ls | grep -iE "^.*_log\.[0-9]{4}-[0-9]{2}-[0-9]{2}.txt$"`
for logfile in $logFiles
do
	datum=`echo $logfile | cut -d "." -f 2`

	#skip everything besides February
	if [ `date -d $datum +%m` != 02 ]; then continue; fi;

	echo "datum: `date -d $datum +%d-%m-%Y`"
	echo "-------------------------------------------------------"
	cut -d '"' -f 2 $logfile | sort | uniq -c | sort -nr
	echo
done
