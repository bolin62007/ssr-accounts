#!/bin/bash

videos=/usr/local/nginx/content/videos/
mkdir -p $videos

mkdir download 
cd download

for s in ../dv_*.sh; do
	echo $s
	bash $s >> dv.log 2>&1
	fname=$(echo $s | cut -d'_' -f2 | cut -d'.' -f1)
	echo $fname	
	mv $fname $videos
done

# move single files
mv *mp4 $vidoes

cd ..

