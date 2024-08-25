#!/bin/bash

# colors
red='\e[31m'
end='\e[0m'

# banner 
function banner() {
	echo
	echo -e "!${red}CRAWLING${end}"
	echo -e "!${red}pad1ryoshi${end}"
	echo
}

# checking if the Katana and anew tools are installed
if ! command -v katana &> /dev/null || ! command -v anew &> /dev/null; then
    echo -e "${red}Error${end}: Katana and/or anew are not installed. Please install them and try again."
    exit 1
fi

# requesting user confirmation and starting crawling
function starting() {
	read -p "Initialize the crawling process? [Y/N] " p
	resp=${p^^} # convert answer to uppercase

	if [ "$resp" != "Y" ]; then
    		echo "Crawling canceled by user or invalid input. Just Y and N are validated!"
    		exit 0
	fi
              
	echo "NOTE: Press CTRL + C to stop crawling!!!"
}

# running Katana one liner
function run_katana {
    	input_file=$1
    	output_file=$2
    	cat $input_file | katana -jc -kf -all -nc -ef -silent png,jpg,jpeg,css,gif,ttf,woff,woff2,svg,eot | anew $output_file
}

# crawling one target
function crawl_one() {
	echo -e "${red}Crawling on one target [X]${end}"
	
	#checking if the file "subs.txt" exists in the directory
	if [ ! -f subs.txt ]; then
    		echo -e "${red}Error${end}: subs.txt not found. Please place the subs.txt file in the current directory and try again."
    		exit 1
	fi

	run_katana "subs.txt" "crawl_subs.txt"
	run_katana "200_info.txt" "crawl_200_info.txt"
}

# crawling many targets
function crawl_all() {
	echo -e "${red}Crawling on many target [X]${end}"
	
	#checking if the file "subs_list.txt" exists in the directory
	if [ ! -f subs_list.txt ]; then
       		echo -e "${red}Error${end}: subs_list.txt not found. Please place the subs_list.txt in the current directory and try again"
       		exit 1
	fi

	run_katana "subs_list.txt" "crawl_subs_list.txt"
	run_katana "200_info_list.txt" "crawl_200_info_list.txt"
}

# putting everything from crawl_one() and crawl_many() on one archive .txt
function crawl_everything() {
	echo -e "${red}Starting crawling on subs.txt, 200_info.txt, subs_list.txt and 200_info_list.txt${end}"
	echo -e "${reD}Putting everything together in only one archive - crawling_all_in_one.txt${end}"
	cat crawl_subs.txt crawl_200_info.txt crawl_subs_list.txt crawl_200_info_list.txt | anew crawling_all_in_one.txt
}

# looping
function looping {
    	while [[ "$resp" == "Y" ]]; do
		clear
		echo -e "${red}Select an option:${end}"
		echo "1) Crawling one target"
		echo "2) Crawling many target's"
		echo "3) Crawling everything -> Run option 1) and 2) before that one."
		echo "4) Exit"
		read -p "Option: " option
		case $option in
			1) crawl_one ;;
			2) crawl_all ;;
			3) crawl_everything ;;
			4) echo -e "${red}Leaving...${end}" ; exit 0 ;;
			*) echo -e "${red}Invalid option!${end}" ; sleep 1 ;;
		esac

        	echo -e "${red}Crawling finished! Do you want to start again?${end} [Y/N]"
        	read -p "" resp
        	resp=${resp^^} # Convert answer to uppercase
		
    	done

    	echo -e "${red}Finished crawling!!!${end}"

}


#main --'

banner
starting
looping
