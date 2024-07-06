#!/bin/bash

# Definição de cores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # Sem cor

# Função para o script de recon
run_rec0n() {
    echo -e "${GREEN}Iniciando script de recon...${NC}"
    ./rec0n.sh
}

# Função para o script de crawling
run_cr4wl() {
    echo -e "${GREEN}Iniciando script de crawling...${NC}"
    ./cr4wl.sh
}


# Menu interativo
while true; do
    clear
    echo -e "${YELLOW}Selecione uma opção:${NC}"
    echo "1) Executar script de recon"
    echo "2) Executar script de crawling"
    echo "3) Sair"
    read -p "Opção: " option
    case $option in
        1) run_rec0n ;;
        2) run_cr4wl ;;
        3) echo -e "${GREEN}Saindo...${NC}" ; exit 0 ;;
        *) echo -e "${RED}Opção inválida!${NC}" ; sleep 1 ;;
    esac
done

