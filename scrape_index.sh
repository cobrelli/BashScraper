export LC_ALL='C'

site=$(wget -qO- http://www.kauppalehti.fi/5/i/porssi/porssikurssit/indeksit.jsp?market=XHEL | gsed -e 's/<\/tr>/BREAK/g' | grep '<td\|BREAK\|<!' ) #| grep '<td' | grep 'num\|a href' | gsed -e 's/OMXH/BREAK/g')
#site=$(echo "$site" | grep '<td')
#echo "$site"
found=0
new=""
line_to_append=""
while read -r line;do
	if [[ "$line" == *Sivun\ alkuun/Printversion\ starts* ]];then
		#new="$new $"
		break
	fi

	if [[ found -eq 0 && "$line" == *Helsingin\ indeksit* ]]; then
		found=1
		#line_to_append="$line"
	elif [[ found -eq 1 ]];then
		#echo "$line"
#		if [[ "$line" == *BREAK* ]];then
#			new="$new $line_to_append\n"
#			line_to_append=""
#			continue;
#		fi
		line_to_append="$line_to_append $line\n"
	fi
done <<< "$site"
#trim=$(echo -e "$new" | gsed -e 's/<[^>]\+>//g' -e 's/^[ \t]*//g' -e 's/.*rssi //g' -e '/^$/d' | sort )
#echo "$trim"

echo -e "$line_to_append"
#echo "$site"