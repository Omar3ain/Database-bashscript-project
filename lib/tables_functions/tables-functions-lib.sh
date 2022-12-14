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
    select choice in "Create Table" "List Tables" "Drop Table" "Insert into Table" "Select From Table" "Delete From Table" "Update Table" "Back"
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
        8)
            cd ..
            First_page=false
            database_page=true
            create_table_page=false
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
            sending_output_to_the_user "${ERRORCOLOR}Cant create a table without a name${ENDCOLOR}"
	elif [[ -e $table_name ]] 
        then
            sending_output_to_the_user "${ERRORCOLOR}This table name is already exsists${ENDCOLOR}"
    elif [[ $table_name =~ [/] ]] 
        then
            sending_output_to_the_user "${ERRORCOLOR}Can't use / in naming the table${ENDCOLOR}"
	elif [[ $table_name =~ ^[a-zA-Z] ]] 
        then
            touch $table_name
            table_fields;
            sending_output_to_the_user "${BABYBLUE}Table created sucessfully${ENDCOLOR}"
	fi
}
function table_fields 
{
  echo "Enter number of columns please"
  read number_of_columns
  if ! [[ "$number_of_columns" = +([1-9])*([0-9]) ]]; then
        echo -e "${ERRORCOLOR}Enter valid number${ENDCOLOR}"
        read number_of_columns
    fi

    for (( i = 0; i < number_of_columns; i++ ));
    do
        get_input "Enter column number $[i+1] name" 
        is_primary_key;
        get_data_size;
        get_data_type;
        if ! [[ i -eq $number_of_columns-1 ]]
        then
        echo -n ":" >> "$table_name"
        fi
    done
}
function list_tables 
{
    echo -e "${BABYBLUE}List of all tables in the database${ENDCOLOR}"
    ls
    read
}
function insert_into_table
{
    echo -e "Type table name please"
    read table_name
    number_of_fields=$(head -1 "$table_name" | awk -F: '{print NF}') 
    for (( i = 0; i < number_of_fields; i++ ));
    do
     echo -e "Enter field $[i+1] data "
     read
     if [[ i -eq $number_of_fields-1 ]]; then
            echo "$REPLY" >> "$table_name"
            echo -e "\e[42mentry inserted successfully\e[0m"
        else
            echo -n "$REPLY": >> "$table_name"
        fi
    done
}