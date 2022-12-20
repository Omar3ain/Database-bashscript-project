#!/bin/bash
function database_title
{
    echo -e "${LIGHTGREY}${BLACK}----------------------------------------------------------------------------------------${ENDCOLOR}"
    echo -e "${LIGHTGREY}${BLACK}|                                                                                      |${ENDCOLOR}"
    echo -e "${LIGHTGREY}${BLACK}|                                                                                      |${ENDCOLOR}"
    echo -e "${LIGHTGREY}${BLACK}|                                                                                      |${ENDCOLOR}"
    echo -e "${LIGHTGREY}${BLACK}|                              WELCOME TO DATABASES PAGE                               |${ENDCOLOR}"
    echo -e "${LIGHTGREY}${BLACK}|                                                                                      |${ENDCOLOR}"
    echo -e "${LIGHTGREY}${BLACK}|                                                                                      |${ENDCOLOR}"
    echo -e "${LIGHTGREY}${BLACK}|                                                                                      |${ENDCOLOR}"  
    echo -e "${LIGHTGREY}${BLACK}----------------------------------------------------------------------------------------${ENDCOLOR}"
    echo
}
function database_page
{
    database_title;
    select choice in "Create Database" "List Databases" "Connect To a Database" "Drop Database" "Back"
    do
    case $REPLY in
        1) 
            CreateDB;
            ;;
        2)  
            List_databases;
            ;;
        3)
            SelectDB
            ;;
        4)
            DropDB
            ;;
        5)
            Back
            cd ..
            First_page=true
            database_page=false
            create_table_page=false
            ;;
        6) 
            exit
            ;;
        *)
            invalid_list_input_handle;
            ;;
    esac
    break
    done
}
function CreateDB 
{
    dbName=$(zenity --entry \
       --width 500 \
       --title "Table name" \
       --text "Enter the Database name please");
	if [[ $dbName = "" ]]
        then
            sending_error "Can't create a database without a name"
	elif [[ -e $dbName ]] 
        then
            sending_error "This database name is already exsists"
	elif [[ $dbName =~ ^[a-zA-Z] ]] 
        then
            mkdir -p "./$dbName"
            cd "./$dbName" > /dev/null 2>&1
            database_page=false
            create_table_page=true
            sending_output_to_the_user "${BABYBLUE}Database created sucessfully${ENDCOLOR}"
            
	else
		make_warning_gui "Warning Input" "Database name can't start with numbers or special characters"
	fi
}
function DropDB 
{
    divider;    

    dbName=$(zenity --entry \
       --width 500 \
       --title "Table name" \
       --text "Enter the Database name please");
        db="$dbName"
        if [[ "$dbName" = '' ]]; then
                sending_error "Can't delete a database without a name"
        elif ! [[ -d "$dbName" ]]; then
                sending_error "This database doesn't exist"    
        else
                rm -r "./$dbName"
                sending_output_to_the_user "$dbName Removed from your databases"
        fi
}
function SelectDB 
{
    divider;
    dbName=$(zenity --entry \
       --width 500 \
       --title "Table name" \
       --text "Enter the Database name please");
        if [[ "$dbName" = '' ]]; then
				make_warning_gui "Warning Input" "please enter a correct name then click enter, Don't try this character again."
        elif ! [[ -d "$dbName" ]]; then
				sending_error "This database_name doesn't exist."
        else
                cd "$dbName"
                database_page=false
                create_table_page=true
        fi
}
function List_databases
{
    divider;
    echo -e "${BABYBLUE}The list of all avaliable databases:${ENDCOLOR}";
    ls;
    read
}