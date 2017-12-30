#!/bin/bash

books=/usr/local/nginx/content/books/
mkdir -p $books

mkdir download 
cd download

for s in ../db_*.sh; do
	bash $s >> db.log 2>&1
	fname=$(echo $s | cut -d'_' -f2 | cut -d'.' -f1)
	echo $fname
	mkdir -p $books/$fname
	mv $fname/* $books/$fname
done

cd ..

