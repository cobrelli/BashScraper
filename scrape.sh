export LC_ALL='C'

site=$(wget -qO- http://www.kauppalehti.fi/5/i/porssi/porssikurssit/ | grep '<td' | grep 'num\|a href' | gsed -e 's/OMXH/BREAK/g')
#i=1
found=0
#on=0
new=""
line_to_append=""
while read -r line;do
	if [[ found -eq 0 && "$line" == *\>P*rssi\</td\>* ]]; then
		#start=$i
		found=1
		#on=1
		line_to_append="$line"
		#continue;
	elif [[ found -eq 1 ]];then
		if [[ "$line" == *BREAK* ]];then
			new="$new $line_to_append\n"
			line_to_append=""
			continue;
		fi
		line_to_append="$line_to_append $line"
		#continue;
#		echo "$line"
#		echo "$i"
		#break
	fi

	#let i++
done <<< "$site"
#echo "$i"
#echo "$start"
#trim=$(echo "$site" | tail -n $((i-start)))
#echo "$trim"
#echo -e "$new" | gsed -e 's/^[ \t]*//g'
trim=$(echo -e "$new" | gsed -e 's/<[^>]\+>//g' -e 's/^[ \t]*//g' -e 's/.*rssi //g' | sort ) #| cut -d ' ' -f1- #-e 's/<.*"//g' -e 's/[. ">a-zöäå?ÖÄÅ]*"\/>//g' -e 's/.*>//g' #-e 's/.*\"\/>//g' #-e 's/\/>//g' #-e 's/.*\/>//g' -e 's/^.*\"\>//g'
echo "$trim" #| cut -d ' ' -f2
#trim=$(echo "$site" | tail -1)
#echo "$site" | head -1 
#echo "$site"
#echo "$trim"
