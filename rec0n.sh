#!/bin/bash

echo
echo
echo xXxXx R E C O N xXxXx
echo -- MADE BY PAD1RYOSHI --
echo
echo

read -p "Iniciar o processo de recon? [S/N]: " sn
echo
echo
if [ $sn == "S" ]; then
	read -p "Digite o nome do domínio: " d
	domain=$d
	echo "INICIALIZANDO SUBFINDER EM: ${domain}"
	subfinder -d ${domain} -all -silent | anew subf.txt
	echo
	echo
	echo "subfinder finalizado [X]"
	echo
	echo
	echo "INICIALIZANDO ASSETFINDER EM: ${domain}"
	assetfinder ${domain} -silent | anew asset.txt
	echo
	echo
	echo "assetfinder finalizado [X]"
	echo
	echo
	echo "Criando arquivo subs.txt"
	cat subf.txt asset.txt | anew subs.txt
	rm subf.txt asset.txt
	echo
	echo
	echo "Obtendo apenas status 200"
	cat subs.txt | httpx -mc 200 -follow-host-redirects -random-agent -status-code -silent -retries 2 -title -web-server -tech-detect -location -o 200_info.txt
fi






