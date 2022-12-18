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
    echo -e "Enter the name of the database please"
	read dbName
	if [[ $dbName = "" ]]
        then
            sending_output_to_the_user "${ERRORCOLOR}Can't create a database without a name${ENDCOLOR}"
	elif [[ -e $dbName ]] 
        then
            sending_output_to_the_user "${ERRORCOLOR}This database name is already exsists${ENDCOLOR}"
	elif [[ $dbName =~ ^[a-zA-Z] ]] 
        then
            mkdir -p "./$dbName"
            cd "./$dbName" > /dev/null 2>&1
            database_page=false
            create_table_page=true
            sending_output_to_the_user "${BABYBLUE}Database created sucessfully${ENDCOLOR}"
	else
		sending_output_to_the_user "${ERRORCOLOR}Database name can't start with numbers or special characters${ENDCOLOR}"
	fi
}
function DropDB 
{
    divider;    
    echo -e "Enter the name of the database"
        read dbName
        db="$dbName"
        if [[ "$dbName" = '' ]]; then
                sending_output_to_the_user "${ERRORCOLOR}Can't delete a database without a name${ENDCOLOR}"
        elif ! [[ -d "$dbName" ]]; then
                sending_output_to_the_user "${ERRORCOLOR}This database doesn't exist${ENDCOLOR}"    
        else
                rm -r "./$dbName"
                sending_output_to_the_user "${BABYBLUE}$dbName Removed from your databases${ENDCOLOR}"
        fi
}
function SelectDB 
{
    divider;
    echo -e "Enter Database Name: "
    read dbName
        if [[ "$dbName" = '' ]]; then
				sending_output_to_the_user "${ERRORCOLOR}please enter a correct name then click enter, Don't try this character again${ENDCOLOR}"
        elif ! [[ -d "$dbName" ]]; then
				sending_output_to_the_user "${ERRORCOLOR}This database_name doesn't exist${ENDCOLOR}"
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