#!/bin/bash
#COLORS
ERRORCOLOR="\e[41m"
BABYBLUE="\e[104m"
LIGHTGREY="\e[47m"
BLACK="\e[30m"
ENDCOLOR="\e[0m"
#LINE MODFIERS
TAB="\t"
NEXTLINE="\n"


function divider 
{
    echo -e "${NEXTLINE}+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++${NEXTLINE}"
}
function invalid_list_input_handle
{
    echo -e "${ERRORCOLOR}Please choose from the list${ENDCOLOR}"
    echo press any key
    read
}
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
# database_page
function database_title
{
    divider;
    echo -e "${NEXTLINE}"
    echo -e "${TAB}${TAB}${TAB}${LIGHTGREY}${BLACK}Welcome to database page${ENDCOLOR}"
    echo -e "${NEXTLINE}"
    divider;
}
function database_page
{
    database_title;
    select choice in "Create Database" "List Databases" "Connect To a Database" "Drop Database" "Back"
    do
    case $REPLY in
        1) 
            createDB;
            ;;
        2) 
            exit
            ;;
        3)
        ;;
        4)
        ;;
        5)
        cd ..
        First_page=true
        database_page=false
        create_table_page=false
        ;;
        *)
            invalid_list_input_handle;
            ;;
    esac
    break
    done
}
function createDB 
{
    echo enter the name of the database please
	read dbName
	if [[ $dbName = "" ]]
        then
            echo -e "${ERRORCOLOR}Cant create a database without a name${ENDCOLOR}"
            echo Please enter a name 
            read	
	elif [[ -e $dbName ]] 
        then
            echo -e "${ERRORCOLOR}This database name is already exsists${ENDCOLOR}"
            echo Please enter another name
            read
	elif [[ $dbName =~ ^[a-zA-Z] ]] 
        then
            mkdir -p "$dbName"
            cd "./$dbName" > /dev/null 2>&1
            echo -e "${BABYBLUE}database created sucessfully${ENDCOLOR}"
            database_page=false
            create_table_page=true
            echo press any key
            read
	else
		echo -e "${ERRORCOLOR}Database name can't start with numbers or special characters${ENDCOLOR}"
		echo Please try again
		read
	fi
}
# Table_page
function table_page_title
{
    divider;
    echo -e "${NEXTLINE}"
    echo -e "${TAB}${TAB}${LIGHTGREY}${BLACK}Welcome to tables page of database '${dbName}' ${ENDCOLOR}"
    echo -e "${NEXTLINE}"
    divider;
} 
function table_page 
{
    table_page_title;
    select choice in "Create Table" "List Tables" "Drop Table" "Insert into Table" "Select From Table" "Delete From Table" "Update Table"
    do
    case $REPLY in
        1)
            create_table;
            ;;
        2)
            list_tables;
            ;;
        3)
            drop_table;
            ;;
        4)
            insert_into_table;
            ;;
        5)
            select_from_table;
            ;;
        6)
            delete_from_table;
            ;;
        7)
            update_table;
            ;;
        *)
            invalid_list_input_handle;
            ;;
    esac
    break
    done
}
function create_table
{
    echo -e "Enter Table name please"
    read table_name
	if [[ $table_name = "" ]]
        then
            echo -e "${ERRORCOLOR}Cant create a table without a name${ENDCOLOR}"
            echo Please enter a name 
            read	
	elif [[ -e $table_name ]] 
        then
            echo -e "${ERRORCOLOR}This table name is already exsists${ENDCOLOR}"
            echo Please enter another name
            read
    elif [[ $table_name =~ [/] ]] 
        then
            echo -e "${ERRORCOLOR}Can't use / in naming the table${ENDCOLOR}"
            echo Please enter another name
            read
	elif [[ $table_name =~ ^[a-zA-Z] ]] 
        then
            touch $table_name
            #table_fields;
            echo -e "${BABYBLUE}Table created sucessfully${ENDCOLOR}"
            echo press any key
            read
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