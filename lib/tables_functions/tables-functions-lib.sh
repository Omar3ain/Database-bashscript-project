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