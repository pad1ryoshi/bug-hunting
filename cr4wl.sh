#!/bin/bash
# colors
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


# checking if the Katana and anew tools are installed
if ! command -v katana &> /dev/null || ! command -v anew &> /dev/null; then
    echo -e "${red}Error${end}: Katana and/or anew are not installed. Please install them and try again."
    exit 1
fi

# checking if the file "subs.txt" exists in the directory
if [ ! -f subs.txt ]; then
    echo -e "${red}Error${end}: subs.txt not found. Please place the subs.txt file in the current directory and try again."
    exit 1
fi

# requesting user confirmation and starting crawling
read -p "Initialize the crawling process? [Y/N] " p
resp=${p^^} # convert answer to uppercase

if [ "$resp" != "Y" ]; then
    echo "Crawling cancelado pelo usuário."
    exit 0
fi

echo "NOTE: Press CTRL + C to stop crawling!!!"

# crawling's loop
while [ "$resp" == "Y" ]; do
    echo "Starting cr4wl1ng"
    cat subs.txt | katana -jc -kf all -nc -ef png,jpg,jpeg,css,gif,ttf,woff,woff2,svg,eot,js | anew crawl.txt
    echo "Crawling finished! Do you want to start again? [Y/N]"
    read p
    resp=${p^^} # convert answer to uppercase
done

echo "Finished crawling!!!"
