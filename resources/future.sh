#!/bin/bash

file_descs=(
25m32s_02182016
23m29s_03082016
22m52s_03102016
21m27s_03102016
25m22s_03102016
31m18s_01222016
40m39s_02182016
41m52s_03292016
53m18s_02282016
46m20s_02282016
)

function format_url(){
	ep=$1
	desc=${file_descs[$((ep-1))]}
	seg=$(printf "%02d" $2)
	ep=$(printf "%02d" $1)
	url=http://media4.minghui.org/media/video/2016/8/10/NowAndForTheFuture/MP4/NowAndForTheFuture${ep}_final_${desc}_NTD_Broadcast_mp4.part${seg}.rar
	echo $url
}

mkdir future

for((i=0; i<10; i++)); do
	ep=$((i+1))
	for((seg=1; seg<=40; seg++)); do
		url=$(format_url $ep $seg)
		wget $url
	done
	unrar e $(basename $(format_url $ep 1))
	rm -fr *.rar
	ep=$(printf "%02d" $ep)
	mv *.mp4 future/$ep.mp4
done




