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