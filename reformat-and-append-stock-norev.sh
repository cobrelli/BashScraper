#!/bin/bash
export LC_ALL='C'

new=$(./scrape_stock_norev.sh)
if [ -f stock.txt ];then
	original=$(cat stock.txt)

	#formatted_new=$(echo -e "$new")
	new_stock="";

	while read -r line;do
		name=$(echo "$line" |cut -d ',' -f1)
		new_line=$(grep -- "$name" stock.txt | head -1)
		new_stock="$new_stock$new_line#$(date +%d.%m.%Y)|$(echo "$line" |cut -d ',' -f2)\n"
	done <<< "$new"

	if [ ! -d "backup" ];then
		echo "backup folder doesn't exist, creating new"
		mkdir backup
	fi
	echo -e "$new_stock" > stock.txt
	echo -e "$original" > backup/stock_backup_$(date +%d.%m.%Y).txt
else
	echo "No existing stock data found, creating new"
	#formatted_new=$(echo -e "$new" |cut -d ',' -f1)
	data_format=""
	while read -r line;do
		line_start=$(echo "$line" |cut -d ',' -f1)
		data_format="$data_format$line_start#$(date +%d.%m.%Y)|$(echo "$line" |cut -d ',' -f2)\n"
	done <<< "$new"
	echo -e "$data_format" > stock.txt
fi