site=$(wget -qO- http://www.kauppalehti.fi/5/i/porssi/porssikurssit/ | grep '<td' | grep 'num\|a href' | gsed -e 's/\ \+//g' -e 's/OMXH/BREAK/g')
echo "$site"