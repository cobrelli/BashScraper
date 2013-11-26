export LC_ALL='C'

site=$(wget -qO- http://www.kauppalehti.fi/5/i/porssi/porssikurssit/ | grep '<td' | grep 'num\|a href' | gsed -e 's/OMXH/BREAK/g')
found=0
new=""
line_to_append=""
while read -r line;do
	if [[ found -eq 0 && "$line" == *\>P*rssi\</td\>* ]]; then
		found=1
		line_to_append="$line"
	elif [[ found -eq 1 ]];then
		if [[ "$line" == *BREAK* ]];then
			new="$new $line_to_append\n"
			line_to_append=""
			continue;
		fi
		line_to_append="$line_to_append $line"
	fi
done <<< "$site"
trim=$(echo -e "$new" | gsed -e 's/<[^>]\+>//g' -e 's/^[ \t]*//g' -e 's/.*rssi //g' -e '/^$/d' -e "s/'//g" | sort )
echo "$trim"

