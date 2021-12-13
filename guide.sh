#!/bin/bash
cd /home/tokariew/tomenet || exit 1
echo "downloading guide"
curl https://www.tomenet.eu/TomeNET-Guide.txt --compressed --silent -o guide.txt
echo "checking for diffrences"
diff guide.txt tomenet-guide/TomeNET-Guide.txt -sq && exit 0

mv guide.txt tomenet-guide/TomeNET-Guide.txt

curl https://www.tomenet.eu/downloads/TomeNET-Guide.pdf --compressed --silent -o tomenet-guide/TomeNET-Guide.pdf

[[ $(date --iso) = $(head -n 1 last.txt) ]] && version=$(sed -n '2p' last.txt) && version=$((version + 1)) || version=1

txt=$(date --iso)
[[ $version -gt 1 ]] && txt="${txt}_${version}"

date --iso | tee last.txt
echo $version >> last.txt

cd tomenet-guide || exit 1
echo "making commit"
git commit -am "$txt"
git push origin master
git push bitbucket master

