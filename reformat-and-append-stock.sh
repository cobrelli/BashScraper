#!/bin/bash
export LC_ALL='C'

new=$(./scrape_stock.sh)
if [ -f stock.txt ];then
	original=$(cat stock.txt)

	formatted_new=$(echo -e "$new" | rev | cut -d ' ' -f8- | rev)
	new_stock="";

	while read -r line;do
		name=$(echo "$line" | rev | cut -d ' ' -f2- | rev)
		new_line=$(grep "$name" stock.txt)
		new_stock="$new_stock$new_line$(date +%d.%m.%Y)|$(echo "$line" | rev | cut -d ' ' -f1 | rev)||\n"
	done <<< "$formatted_new"
	echo -e "$new_stock" > stock.txt
	echo -e "$original" > stock_backup_$(date +%d.%m.%Y).txt
else
	echo "No existing stock data found, creating new"
	formatted_new=$(echo -e "$new" | rev | cut -d ' ' -f8- | rev)
	data_format=""
	while read -r line;do
		line_start=$(echo "$line" | rev | cut -d ' ' -f2- | rev)
		data_format="$data_format $line_start||$(date +%d.%m.%Y)|$(echo "$line" | rev | cut -d ' ' -f1 | rev)||\n"
	done <<< "$formatted_new"
	echo -e "$data_format" > stock.txt
fi