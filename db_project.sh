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
# First_page
function title 
{
    divider;
    echo -e "${TAB}${LIGHTGREY}${BLACK}Bash shell Script project - DBMS Clone${ENDCOLOR}"
    echo -e "${TAB}${LIGHTGREY}${BLACK}Open source Applictions development - intake 430${ENDCOLOR}"
    echo -e "${TAB}${LIGHTGREY}${BLACK}Omar medhat abdelfattah - Montanser hassan${TAB}${ENDCOLOR}"
    divider;
}
function First_page
{
    title;
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
            echo -e "${ERRORCOLOR}Please choose from the list${ENDCOLOR}"
            echo press any key
            read
            ;;
    esac
    break
    done
}

function database_page
{
    select choice in "Create Database" "List Databases" "Connect To Databases" "Drop Database"
    do
    case $REPLY in
        1) 
            createDB;
            ;;
        2) 
            exit
            ;;
        *)
            echo -e "${ERRORCOLOR}Please choose from the list${ENDCOLOR}"
            echo press any key
            read
            ;;
    esac
    break
    done
}
function createDB {

    echo -e "Enter The name of database please:"
    read dbName
    if [[ $dbName = "" ]]
    then
    echo -e "${ERRORCOLOR}Please type the name of database${ENDCOLOR}"
    echo "Waiting for you database name"
    read
    fi [[ ]]


}

while true; do
	while $First_page;
    do	
		clear
		First_page;
	done
    while $database_page;
    do
        clear
        database_page;
    done
done