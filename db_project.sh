#!/bin/bash
source lib/modifiers/colors_line_modifiers.sh
source lib/modifiers/structure_modifiers.sh
source lib/database_functions/database.functions-lib.sh
source lib/tables_functions/tables-functions-lib.sh
source lib/modifiers/print_methods.sh
source lib/modifiers/GUI.sh

printf '\033[8;1;1t'
# First_page
while $first_time 
    do
    zenity --info --text="
            Welcome to DBMS bash project

            Made by      

            OMAR MEDHAT 
            MONTASER HASSAN" --title=DBMS --width=500 --height=300 
        
    first_time=false
    done

function First_page
{
    asnwer=$(zenity --list \
                    --title="Database DBMS" \
                    --text "Select how would you start?" \
                    --radiolist \
                    --cancel-label="Exit" \
                    --column "Pick" \
                    --column "Answer" \
                    --width=1000 \
                    --height=500 \
                    TRUE "Create or enter database")
            if [[ $asnwer == "Create or enter database" ]];then
            if ! [[ -e `pwd`/databases ]];
                then
                mkdir  -p ./databases
                fi
                cd ./databases
            (
                echo 10
                echo "# Reading User Input" 
                sleep 0.5
                
                echo 15
                echo "# Reading databases available"
                sleep 0.5

                echo 50
                echo "# Installing databases..."
                sleep 0.5

                echo 100
                echo "# database loading completed!"
                ) | zenity --title "Database Loading Progress Bar" --progress --auto-close --width="600"
            First_page=false
            database_page=true
        else
        exit
    fi
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