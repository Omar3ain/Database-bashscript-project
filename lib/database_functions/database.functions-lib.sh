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
function back_function_database
{
                    ret=$?
                    if ! [[ "$ret" == 0 ]] || [[ "$ asnwer" == '' ]]; then
                    First_page=false
                    database_page=true
                    create_table_page=false
                    fi
}
function database_page
{
     asnwer=$(zenity --list \
                    --title="Database DBMS" \
                    --text "Select From menu please" \
                    --radiolist \
                    --column "Pick" \
                    --cancel-label="Go back" \
                    --column "Answer" \
                    --width=1000 \
                    --height=500 \
                    TRUE "Create Database" \
                    FALSE "List Databases" \
                    FALSE "Connect To a Database" \
                    FALSE "Drop Database" )
                    ret=$?
                    if ! [[ "$ret" == 0 ]] || [[ "$ dbName" == '' ]]; then
                        cd .. 
                    First_page=true
                    database_page=false
                    create_table_page=false
                    return
                    fi

                    if [[ $asnwer == "Create Database" ]];then
                    CreateDB;
                    back_function_database;
                    elif [[ $asnwer == "List Databases" ]];then
                    List_databases;
                    back_function_database;
                    elif [[ $asnwer == "Connect To a Database" ]];then
                    SelectDB;
                    back_function_database;
                    elif [[ $asnwer == "Drop Database" ]];then
                    DropDB;
                    back_function_database;
                    elif [[ $asnwer == "Back" ]];then
                      (
                        echo 10
                        echo "# Back to Main page"
                        sleep 2

                        echo 100
                        echo "# main page loading completed!"
                        ) | zenity --title "Main page Loading Progress Bar" --progress --auto-close --width="600"
                    cd ..
                    First_page=true
                    database_page=false
                    create_table_page=false
    fi
}
function CreateDB 
{
    dbName=$( get_input_gui "Database name" "Enter the Database name please");
	if [[ $dbName = "" ]]
        then
            sending_error "Can't create a database without a name"
	elif [[ -e $dbName ]] 
        then
            sending_error "This database name is already exsists"
	elif [[ $dbName =~ ^[a-zA-Z] ]] 
        then
            (
                echo 10
                echo "# Reading User Input"
                sleep 1

                echo 15
                echo "# Reading database tables"
                sleep 1

                echo 70
                echo "# Installing tables..."
                sleep 1

                echo 100
                echo "# database loading completed!"
                ) | zenity --title "Database Loading Progress Bar" --progress --auto-close --width="600"
            mkdir -p "./$dbName"
            cd "./$dbName" > /dev/null 2>&1
            database_page=false
            create_table_page=true
            notify-send "Database status" "Database Created successfully."
	else
		make_warning_gui "Warning Input" "Database name can't start with numbers or special characters"
	fi
}
function DropDB 
{
     if [ -z "$(ls -A . )" ]; then
        make_warning_gui "Warning" "No Databases available"
        else
        dbName=$(zenity --title="Databases available" --text="" --list --column="Databases" $(ls))
        ret=$?
        if ! [[ "$ret" == 0 ]] || [[ "$ dbName" == '' ]]; then
            return
        fi
        if zenity --question --title="Confirm deletion" --text="Are you sure you want to delete this database ("$dbName")?" --no-wrap 
        then
        rm -r "$dbName"
		notify-send "Database status" "Database removed successfully."
        fi
        fi
}
function SelectDB 
{
     if [ -z "$(ls -A . )" ]; then
        make_warning_gui "Warning" "No Databases available"
        else
        dbName=$(zenity --title="Databases available" --text="" --list --column="Databases" $(ls))
        ret=$?
        if ! [[ "$ret" == 0 ]] || [[ "$ dbName" == '' ]]; then
            return
        fi
            (
                echo 10
                echo "# Reading User Input"
                sleep 1

                echo 15
                echo "# Reading database tables"
                sleep 1

                echo 70
                echo "# Installing tables..."
                sleep 1

                echo 100
                echo "# database loading completed!"
                ) | zenity --title "Database Loading Progress Bar" --progress --auto-close --width="600"
            cd "$dbName"
            database_page=false
            create_table_page=true
        fi
}
function List_databases
{
    if [ -z "$(ls -A . )" ]; then
        make_warning_gui "Warning" "No Databases available"
        else
        zenity --title="Database available" --text="" --list --column="Databases" $(ls)
        fi
}