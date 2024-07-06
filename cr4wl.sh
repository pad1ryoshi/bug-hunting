#!/bin/bash
# Cores
red='\e[31m'
end='\e[0m'

echo "  ____ ____ ____ ____ ____ ____ ____ ____ ____ ____ "
echo -e " ||${red}C${end} |||${red}R${end} |||${red}A${end} |||${red}W${end} |||${red}L${end} |||${red}I${end} |||${red}N${end} |||${red}G${end} |||! |||! ||"
echo " ||__|||__|||__|||__|||__|||__|||__|||__|||__|||__||"
echo " |/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|"
echo "made by"
echo
echo "!"
echo -e " <script>${red}pad1ryoshi${end}</script> "
echo -e "    brazillian hacker${red}'--${end}"
echo "!"
echo
echo


# Verificando se as ferramentas Katana e anew existem na máquina
if ! command -v katana &> /dev/null || ! command -v anew &> /dev/null; then
    echo -e "${red}Erro${end}: katana e/ou anew não estão instalados. Por favor, instale-os e tente novamente."
    exit 1
fi

# Verificando se o arquivo "subs.txt" existe no diretório
if [ ! -f subs.txt ]; then
    echo -e "${red}Erro${end}: subs.txt não encontrado. Por favor, coloque o arquivo subs.txt no diretório atual e tente novamente."
    exit 1
fi

# Solicitando a confirmação do usuário e iniciando o crawling
read -p "Inicializar o processo de crawling? [S/N] " p
resp=${p^^} # Converter resposta para maiúscula

if [ "$resp" != "S" ]; then
    echo "Crawling cancelado pelo usuário."
    exit 0
fi

echo "OBS: Pressione CTRL + C para parar o crawling!!!"

# Loop de crawling
while [ "$resp" == "S" ]; do
    echo "Iniciando cr4wl1ng"
    cat subs.txt | katana -jc -kf all -nc -ef png,jpg,jpeg,css,gif,ttf,woff,woff2,svg,eot,js | anew crawl.txt
    echo "Crawling finalizado! Deseja iniciar novamente? [S/N]"
    read p
    resp=${p^^} # Converter resposta para maiúscula
done

echo "Crawling finalizado!!!"
