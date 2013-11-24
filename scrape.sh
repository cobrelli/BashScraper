site=$(wget -qO- http://www.kauppalehti.fi/5/i/porssi/porssikurssit/ | grep '<td' | grep 'num\|a href' | gsed -e 's/\ \+//g' -e 's/OMXH/BREAK/g')
i=1
found=0
while read -r line;do
	if [[ found -eq 0 && "$line" == *\>P*rssi\</td\>* ]]; then
		start=$i
		found=1
#		echo "$line"
#		echo "$i"
		#break
	fi
	let i++
done <<< "$site"
#echo "$i"
#echo "$start"
trim=$(echo "$site" | tail -n $((i-start)))
echo "$trim"
#trim=$(echo "$site" | tail -1)
#echo "$site" | head -1 
#echo "$site"
#echo "$trim"

