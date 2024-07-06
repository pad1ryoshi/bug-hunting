#!/bin/bash

# colors
RED='\e[31m'
GREEN='\e[32m'
YELLOW='\e[33m'
NC='\e[0m' # no color

# Banner
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

# Verify that the necessary commands are installed
if ! command -v subfinder &> /dev/null || ! command -v anew &> /dev/null || ! command -v assetfinder &> /dev/null || ! command -v httpx &> /dev/null; then
    echo -e "${RED}Error: subfinder, anew, assetfinder and/or httpx are not installed. Please install them and try again.${NC}"
    exit 1
fi

read -p "Start the recon process? [Y/N]: " yn
echo
echo

if [[ ${sn^^} == "Y" ]]; then
    read -p "Enter the domain name: " domain

    if [ -z "$domain" ]; then
        echo -e "${RED}Error: No domain provided.${NC}"
        exit 1
    fi

    echo -e "${GREEN}INITIALIZING SUBFINDER IN: ${domain}${NC}"
    subfinder -d ${domain} -all -silent | anew subf.txt
    echo
    echo -e "${GREEN}finished subfinder [X]${NC}"
    echo
    echo

    echo -e "${GREEN}INITIALIZING ASSETFINDER IN: ${domain}${NC}"
    assetfinder ${domain} -silent | anew asset.txt
    echo
    echo -e "${GREEN}finished assetfinder [X]${NC}"
    echo
    echo

    echo -e "${GREEN}Creating subs.txt file${NC}"
    cat subf.txt asset.txt | anew subs.txt
    rm subf.txt asset.txt
    echo
    echo

    echo -e "${GREEN}Getting only status 200 and more juicy info${NC}"
    cat subs.txt | httpx -mc 200 -follow-host-redirects -random-agent -status-code -silent -retries 2 -title -web-server -tech-detect -location -o 200_info.txt
    echo -e "${GREEN}Recon process completed.${NC}"
else
    echo -e "${YELLOW}Recon process canceled by user.${NC}"
fi

