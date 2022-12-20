#!/bin/bash
source lib/modifiers/colors_line_modifiers.sh
source lib/modifiers/structure_modifiers.sh
source lib/database_functions/database.functions-lib.sh
source lib/tables_functions/tables-functions-lib.sh
source lib/modifiers/print_methods.sh
source lib/modifiers/GUI.sh


# First_page
function Main_page_title 
{
    tput bold
    echo -e "${LIGHTGREY}${BLACK}----------------------------------------------------------------------------------------${ENDCOLOR}"
    tput bold
    echo -e "${LIGHTGREY}${BLACK}|                                                                                      |${ENDCOLOR}"
    tput bold
    echo -e "${LIGHTGREY}${BLACK}|                                                                                      |${ENDCOLOR}"
    tput bold
    echo -e "${LIGHTGREY}${BLACK}|                           Bash shell Script project - DBMS                           |${ENDCOLOR}"
    tput bold
    echo -e "${LIGHTGREY}${BLACK}|                                                                                      |${ENDCOLOR}"
    tput bold
    echo -e "${LIGHTGREY}${BLACK}|                      Omar medhat abdelfattah - Montanser hassan                      |${ENDCOLOR}"
    tput bold
    echo -e "${LIGHTGREY}${BLACK}|                                                                                      |${ENDCOLOR}"
    tput bold
    echo -e "${LIGHTGREY}${BLACK}|                                                                                      |${ENDCOLOR}"
    tput bold
    echo -e "${LIGHTGREY}${BLACK}----------------------------------------------------------------------------------------${ENDCOLOR}"
    echo
}
function First_page
{
    Main_page_title;
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