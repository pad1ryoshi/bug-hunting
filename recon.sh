#!/bin/bash

# colors
RED='\e[31m'
GREEN='\e[32m'
YELLOW='\e[33m'
NC='\e[0m' # no color

# Banner
function banner() {
	echo
	echo -e "${GREEN}!RECON${NC}"
	echo -e "${GREEN}!pad1ryoshi${NC}"
	echo
}

# Verify that the necessary commands are installed
if ! command -v subfinder &> /dev/null || ! command -v anew &> /dev/null || ! command -v assetfinder &> /dev/null || ! command -v httpx &> /dev/null; then
    echo -e "${RED}Error: subfinder, anew, assetfinder and/or httpx are not installed. Please install them and try again.${NC}"
    exit 1
fi

function recon_one() {
	echo -e "${GREEN}Start the recon process?${NC} ${YELLOW}[Y/N]:${NC} "
	read -p "" yn
	echo

	if [[ ${yn^^} == "Y" ]]; then
		echo -e "${GREEN}Enter the domain name${NC} ${YELLOW}[ex: example.com]${NC}"
    		read -p "" domain

    		if [ -z "$domain" ]; then
        		echo -e "${RED}Error: No domain provided.${NC}"
        		exit 1
    		fi

    		echo -e "${GREEN}INITIALIZING SUBFINDER IN: ${domain}${NC}"
    		subfinder -d ${domain} -all -silent | anew subf.txt
		cat subf.txt | httpx -silent -mc 200 | anew subf.txt
    		echo -e "${GREEN}Finished subfinder [X]${NC}"
    		echo
    		echo

    		echo -e "${GREEN}INITIALIZING ASSETFINDER IN: ${domain}${NC}"
    		assetfinder -subs-only ${domain} -silent | anew asset.txt
		cat asset.txt | httpx -silent -mc 200 | anew asset.txt
    		echo -e "${GREEN}Finished assetfinder [X]${NC}"
    		echo
    		echo

    		echo -e "${GREEN}Creating subs.txt file${NC}"
    		cat subf.txt asset.txt | anew subs.txt
    		rm subf.txt asset.txt
    		echo
    		echo
		
		echo -e "${GREEN}Getting only status 200${NC}"
		cat subs.txt | httpx -silent -mc 200 | anew subs.txt
		echo
		echo

    		echo -e "${GREEN}Getting only status 200 and more juicy info${NC}"
    		cat subs.txt | httpx -silent -follow-redirects -status-code -title -stats -web-server -tech-detect -title -ip -o 200_info.txt
    		echo -e "${GREEN}Finishing!${NC}"

	elif [[ ${yn^^} == "N" ]]; then
                echo -e "${YELLOW}Bye bye${NC}"
                exit 0
	else
		echo -e "${RED}Invalid output. Only Y or N.${NC}"
	fi
}

function recon_many() {
	echo -e "${GREEN}Start the recon process${NC} - ${YELLOW}[Y/N]${NC}"
	read -p "" yn
	echo
	echo -e "${GREEN}List name with domains or subdomains${NC} - ${YELLOW}[ex: domains.txt]${NC}"
	read -p "" list

	if [[ ${yn^^} == "Y" ]]; then

		if [ -z ${list} ]; then
			echo -e "${RED}Error: No list provided.${NC}"
			exit 1
		fi

		if [ ! -s ${list} ]; then
			echo -e "${RED}Error: No list provided or file is empty.${NC}"
			exit 1
		fi

		echo
		echo -e "${GREEN}INITIALIZING SUBFINDER [X]${NC}"
		subfinder -dL $list -silent | anew subf_list.txt
		echo -e "${GREEN}FINISHED SUBFINDER [X]${NC}"
		echo
		echo

		echo -e "${GREEN}INITIALIZING ASSETFINDER [X]${NC}"
		cat $list | xargs -n1 assetfinder --subs-only | anew asset_list.txt
		echo -e "${GREEN}FINISHED ASSETFINDER [X]${NC}"
		echo
		echo

		echo -e "${GREEN}Creating subs_list.txt${NC}"
		cat subf_list.txt asset_list.txt | anew subs_list.txt
		rm subf_list.txt asset_list.txt
		echo
		echo
		
		echo -e "${GREEN}Getting only status 200${NC}"
		cat subs_list.txt | httpx -mc 200 -silent | anew subs_list.txt
		echo
		echo

		echo -e "${GREEN}Getting only status 200 and more juicy${NC}"
		cat subs_list.txt | httpx -silent -follow-redirects -status-code -title -stats -web-server -tech-detect -title -ip -o 200_info_list.txt
		echo -e ${GREEN}Finishing!${NC}
		echo
		echo

	elif [[ ${yn^^} == "N" ]]; then
		echo "${YELLOW}Bye bye${NC}"
		exit 0
	else
		echo -e "${RED}Invalid input. Only Y or N${NC}"
	fi
}

function one_or_many() {
	while true; do
    		clear
    		echo -e "${YELLOW}Select :${NC}"
    		echo "1) Run recon on one target"
    		echo "2) Run recon on many target"
		echo "3) Leaving"
		echo "*)"
    		read -p "Option: " option
    		case $option in
        		1) recon_one ;;
        		2) recon_many ;;
        		3) echo -e "${GREEN}Leaving...${NC}" ; exit 0 ;;
        		*) echo -e "${RED}Invalid option!${NC}" ; sleep 1 ;;
    		esac
	done
}


banner
one_or_many
