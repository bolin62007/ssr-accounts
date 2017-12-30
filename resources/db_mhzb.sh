#!/bin/bash

function format_url(){
	local num=$1
	local url=http://package.minghui.org/dafa_baozhang/mhzb/${num}/MHZB_${num}_pdf.zip
	echo $url
}

target=/usr/local/nginx/content/books/mhzb
index=$(ls -r $target | head -n 1 | cut -d'_' -f2)
if [ -z $index ]; then
	index=600
fi
echo $index
mkdir mhzb

for((num=index; num<2000; num++)); do
	url=$(format_url $num)
	wget $url || break
	unzip MHZB*.zip
	rm -fr MHZB*.zip
	mv MHZB*.pdf mhzb
done

