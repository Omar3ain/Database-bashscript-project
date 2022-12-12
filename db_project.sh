#!/bin/bash
source lib/modifiers/colors_line_modifiers.sh
source lib/modifiers/structure_modifiers.sh
source lib/database_functions/database.functions-lib.sh
source lib/tables_functions/tables-functions-lib.sh

# First_page
function Main_page_title 
{
    divider;
    echo -e "${TAB}${LIGHTGREY}${BLACK}Bash shell Script project - DBMS Clone${ENDCOLOR}"
    echo -e "${TAB}${LIGHTGREY}${BLACK}Open source Applictions development - intake 430${ENDCOLOR}"
    echo -e "${TAB}${LIGHTGREY}${BLACK}Omar medhat abdelfattah - Montanser hassan${TAB}${ENDCOLOR}"
    divider;
}
function First_page
{
    Main_page_title;
    echo `pwd`
    select choice in "Create or enter database" "Exit"
    do
    case $REPLY in
        1) if ! [[ -e `pwd`/databases ]];
            then
            mkdir  -p ./databases
            fi
            cd ./databases
            First_page=false
            database_page=true
            divider;
            echo -e "${BABYBLUE}Loading...${ENDCOLOR}"
            echo press any key
            read 
            ;;
        2) 
            exit
            ;;
        *)
            invalid_list_input_handle;
            ;;
    esac
    break
    done
}

while true; do
	while $First_page;
    do	
		clear;
		First_page;
	done
    while $database_page;
    do
        clear;
        database_page;
    done
    while $create_table_page;
    do
        clear;
        table_page;
    done
done