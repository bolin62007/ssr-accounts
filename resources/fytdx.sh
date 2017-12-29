#!/bin/bash

function format_url(){
	ep=$1
	seg=$(printf "%02d" $2)
	url=http://media4.minghui.org/media/video/2016/8/28/FYTDX/MP4/ZXJM_s2_e${ep}_v1_i0-FYTDX_${ep}-video_480P_mp4.part${seg}.rar
	echo $url
}

segs_of_ep=(16 12 16 21 12 10)
for((i=0; i<${#segs_of_ep[@]}; i++)); do
	ep=$((i+1))
	segs=${segs_of_ep[$i]}
	for((seg=1; seg<=segs; seg++)); do
		url=$(format_url $ep $seg)
		wget $url
	done
	unrar e $(basename $(format_url $ep 1))
	rm -fr *.rar
done

zip FYTDX.zip *.mp4
rm -fr *.mp4



