export LC_ALL='C'

site=$(wget -qO- http://www.kauppalehti.fi/5/i/porssi/porssikurssit/indeksit.jsp?market=XHEL | gsed -e 's/<\/tr>/BREAK/g' | grep '<td\|BREAK\|<!' )
found=0
new=""
line_to_append=""
while read -r line;do
	if [[ "$line" == *Sivun\ alkuun/Printversion\ starts* ]];then
		break
	fi
	if [[ found -eq 0 && "$line" == *Helsingin\ indeksit* ]]; then
		found=1
	elif [[ found -eq 1 ]];then
		if [[ "$line" == *BREAK* ]];then
			new="$new $line_to_append\n"
			line_to_append=""
			continue;
		fi
		line_to_append="$line_to_append $line"
	fi
done <<< "$site"
trim=$(echo -e $new | gsed -e 's/.*>Nimi<.*//g' -e '/^$/d' -e 's/<[^>]\+>/,/g' -e 's/&nbsp;/@/g' -e 's/@\+/-/g' -e 's/,\+/,/g' -e 's/^[ \t]*//g' -e 's/,-,/-/g' -e 's/^[,]//g' -e 's/, ,/,/g' -e|cut -d ',' -f1,2)
echo -e "$trim"