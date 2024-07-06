#!/bin/bash

# colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # no color

# Function for the recon script
run_rec0n() {
    echo -e "${GREEN}Starting recon script...${NC}"
    ./rec0n.sh
}

# Function for the crawling script
run_cr4wl() {
    echo -e "${GREEN}Starting crawling script...${NC}"
    ./cr4wl.sh
}


# Menu interativo
while true; do
    clear
    echo -e "${YELLOW}Select an option:${NC}"
    echo "1) Run recon script"
    echo "2) Run crawling script"
    echo "3) Leave"
    read -p "Option: " option
    case $option in
        1) run_rec0n ;;
        2) run_cr4wl ;;
        3) echo -e "${GREEN}Leaving...${NC}" ; exit 0 ;;
        *) echo -e "${RED}Invalid option!${NC}" ; sleep 1 ;;
    esac
done

