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
    select choice in "Create Table" "List Tables" "Drop Table" "Insert into Table" "Select From Table" "Delete From Table" "Update row in table" "Back"
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
            echo -e "${ERRORCOLOR}Enter valid number please${ENDCOLOR}"
            read number_of_columns
        fi

        for (( i = 1; i <= number_of_columns; i++ ));
        do
            get_input "Enter column number $[i] name" 
            is_primary_key;
            get_data_size;
            get_data_type;
            if ! [[ i -eq $number_of_columns ]]
            then
            echo -n ":" >> "$table_name"
            fi
        done
        echo >> "$table_name"
}
function drop_table 
{
    divider;
    echo "enter the name of the table that you want to delete: "
	read table_name
	if ! [[ -f "$table_name" ]]; then
		sending_output_to_the_user "${ERRORCOLOR}this table doesn't exist${ENDCOLOR}"
	else
		rm "$table_name"
		sending_output_to_the_user "${BABYBLUE}table deleted${ENDCOLOR}"
	fi
}
function list_tables 
{
    echo -e "${BABYBLUE}List of all tables in the database${ENDCOLOR}"
    ls
    read
}

# Insert Into Table
function insert_into_table
{
    echo "Type table name please"
    read table_name
    if ! [[ -f "$table_name" ]]; then
    sending_output_to_the_user "${ERRORCOLOR}This table does not exist${ENDCOLOR}"
    else
        number_of_fields=$(head -1 "$table_name" | awk -F: '{print NF}') 
        for (( i = 1; i <= number_of_fields; i++ ));
        do
        echo -e "Enter field $[i] data "
        read
            notValidData=true
            while $notValidData
            do
            check_type=$(check_datatype $table_name $i $REPLY)
            if [[ "$check_type" == 0 ]]; 
            then 
                echo -e "${ERRORCOLOR}Invalid datatype${ENDCOLOR}"
                echo -e "${ERRORCOLOR}Enter field $[i] data again${ENDCOLOR}"
                read
                else
                    check_size=$(check_for_size $table_name $i $REPLY)
                    if [[ "$check_size" == 0 ]]
                    then
                        echo -e "${ERRORCOLOR}Invalid dataSize${ENDCOLOR}"
                        echo -e "${ERRORCOLOR}Enter field $[i] data again${ENDCOLOR}"
                        read
                    else
                    notValidData=false
                fi
            fi
            done
            if [[ i -eq $number_of_fields ]] 
            then
                echo "$REPLY" >> "$table_name"
                echo -e "\e[42mentry inserted successfully${ENDCOLOR}"
        else
            echo -n "$REPLY": >> "$table_name"
            else
                echo  -n "$REPLY": >> "$table_name"
        fi
        done
        echo -e "${BABYBLUE}Data inserted successfully${ENDCOLOR}"
        read
    fi
}
function update_table 
{
    echo "Type table name please"
    read table_name
    if ! [[ -f "$table_name" ]]; then
    sending_output_to_the_user "${ERRORCOLOR}This table does not exist${ENDCOLOR}"
    else
        
    fi

}

# Select From Table

# Delete From Table
function delete_from_table 
{
    echo -e "Enter Table Name: "
    read table_name
        if ! [[ -f "$table_name" ]]
                then
                    sending_output_to_the_user "${ERRORCOLOR}This Table $table_name NOT here, please try again${ENDCOLOR}"
                else
                    echo -e "Enter Condition column name: "
                    read column
                    col=$(awk 'BEGIN{FS="|"}{if(NR==1){for(i=1;i<=NF;i++){if($i=="'$column'") print i}}}' $table_name)
                if [[ $col == "" ]]
                then
                sending_output_to_the_user "${ERRORCOLOR}Result NOT here${ENDCOLOR}"
                    table_page;
                else
                    echo -e "Enter Condition Value: "
                    read value
                    result=$(awk 'BEGIN{FS="|"}{if ($'$col'=="'$value'") print $'$col'}' $table_name)
                if [[ $result == "" ]]
                then
                    sending_output_to_the_user "${ERRORCOLOR}Result NOT here${ENDCOLOR}"
                    table_page;
                else
                    Num_Record=$(awk 'BEGIN{FS="|"}{if ($'$col'=="'$value'") print Num_Record}' $table_name 2>>./.error.log)
                    sed -i ''$Num_Record'd' $table_name
                    sending_output_to_the_user "${BABYBLUE}Done, Row Deleted${ENDCOLOR}"
                    table_page;
                fi
        fi
}