#!/bin/bash

echo
echo
echo xXxXx CRAWLING xXxXx
echo -- MADE BY PAD1RYOSHI --
echo
echo

echo "Script para realizar crawling quantas vezes o user quiser"
read -p "Inicializar o processo de crawling? [S/N] " p
resp=$p
echo "OBS: CONTROL + C PARA PARAR O CRAWLING!!!"

while [ ${resp} == "S" ]; do
	echo "Iniciando cr4wl1ng"
	cat subs.txt | katana -jc -kf all -nc -ef png,jpg,jpeg,css,gif,ttf,woff,woff2,svg,eot,js | anew crawl.txt
done
echo "Crawling finalizado!!!"

