#!/bin/bash
export LC_ALL='C'

new=$(./scrape_index_norev.sh)
if [ -f index.txt ];then
	original=$(cat index.txt)

	#formatted_new=$(echo -e "$new")
	new_index="";
	while read -r line;do
		name=$(echo "$line" |cut -d ',' -f1)
		new_line=$(grep -- "$name" index.txt | head -1)
		new_index="$new_index$new_line#$(date +%d.%m.%Y)|$(echo "$line" |cut -d ',' -f2)\n"
	done <<< "$new"

	if [ ! -d "backup" ];then
		echo "backup folder doesn't exist, creating new"
		mkdir backup
	fi
	echo -e "$new_index" > index.txt
	echo -e "$original" > backup/index_backup_$(date +%d.%m.%Y).txt
else
	echo "No existing index data found, creating new"
	#formatted_new=$(echo -e "$new" | rev | cut -d ' ' -f6- | rev)
	data_format=""
	while read -r line;do
		line_start=$(echo "$line" |cut -d ',' -f1)
		data_format="$data_format$line_start#$(date +%d.%m.%Y)|$(echo "$line" | cut -d ',' -f2)\n"
	done <<< "$new"
	echo -e "$data_format" > index.txt
fi