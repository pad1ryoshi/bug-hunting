#!/bin/bash

# Definição de cores
RED='\e[31m'
GREEN='\e[32m'
YELLOW='\e[33m'
NC='\e[0m' # Sem cor

echo
echo
echo -e "${YELLOW}  ____ ____ ____ ____ ____ ____ ${NC}"
echo -e "${YELLOW} ||R |||E |||C |||O |||N |||! ||${NC}"
echo -e "${YELLOW} ||__|||__|||__|||__|||__|||__||${NC}"
echo -e "${YELLOW} |/__\|/__\|/__\|/__\|/__\|/__\|${NC}"
echo -e "${GREEN}made by${NC}"
echo
echo -e "${GREEN}!${NC}"
echo -e "${GREEN}!pad1ryoshi${NC}"
echo -e "${GREEN}!brazilian hacker${NC}"
echo -e "${GREEN}!${NC}"
echo
echo

# Verificar se os comandos necessários estão instalados
if ! command -v subfinder &> /dev/null || ! command -v anew &> /dev/null || ! command -v assetfinder &> /dev/null || ! command -v httpx &> /dev/null; then
    echo -e "${RED}Erro: subfinder, anew, assetfinder e/ou httpx não estão instalados. Por favor, instale-os e tente novamente.${NC}"
    exit 1
fi

read -p "Iniciar o processo de recon? [S/N]: " sn
echo
echo

if [[ ${sn^^} == "S" ]]; then
    read -p "Digite o nome do domínio: " domain

    if [ -z "$domain" ]; then
        echo -e "${RED}Erro: Nenhum domínio fornecido.${NC}"
        exit 1
    fi

    echo -e "${GREEN}INICIALIZANDO SUBFINDER EM: ${domain}${NC}"
    subfinder -d ${domain} -all -silent | anew subf.txt
    echo
    echo -e "${GREEN}subfinder finalizado [X]${NC}"
    echo
    echo

    echo -e "${GREEN}INICIALIZANDO ASSETFINDER EM: ${domain}${NC}"
    assetfinder ${domain} -silent | anew asset.txt
    echo
    echo -e "${GREEN}assetfinder finalizado [X]${NC}"
    echo
    echo

    echo -e "${GREEN}Criando arquivo subs.txt${NC}"
    cat subf.txt asset.txt | anew subs.txt
    rm subf.txt asset.txt
    echo
    echo

    echo -e "${GREEN}Obtendo apenas status 200${NC}"
    cat subs.txt | httpx -mc 200 -follow-host-redirects -random-agent -status-code -silent -retries 2 -title -web-server -tech-detect -location -o 200_info.txt
    echo -e "${GREEN}Processo de recon finalizado.${NC}"
else
    echo -e "${YELLOW}Processo de recon cancelado pelo usuário.${NC}"
fi

