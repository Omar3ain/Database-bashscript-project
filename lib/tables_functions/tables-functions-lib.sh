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
    select choice in "Create Table" "List Tables" "Drop Table" "Insert into Table" "Select From Table" "Delete From Table" "Update row in table" "Display table" "Back"
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
            display_table;
            ;;
        9)
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
            if [[ i -eq 1 ]]; then
                get_input "Enter primary column data"
            else
                get_input "Enter column number $[i] name" 
            fi
            is_primary_key $i;
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
        if [[ i -eq 1 ]]; then
            usedPrimaryKey=true
            while $usedPrimaryKey
            do
                primarynumber=$(cut -d ':' -f1 $table_name | awk '{if(NR != 1) print $0}' | grep -x -e "$REPLY") 
                if ! [[ "$primarynumber" == '' ]]; then
                    echo -e "${ERRORCOLOR}Used primary number${ENDCOLOR}"
                    read
                else
                    usedPrimaryKey=false
                fi
            done
        fi

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
                        validData "$REPLY"
                        read
                    else
                    notValidData=false
                fi
            fi
            done
            if [[ i -eq $number_of_fields ]] 
            then
                echo "$REPLY" >> "$table_name"
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
        echo "Type column name you want to change its data please"
        isFieldName "$table_name"
        col=$isFieldName

        echo "Type row number you want to update please"
        read row

        notnumber=true
        while $notnumber 
            do
            if ! [[ "$row" = ?(-)+([0-9])?(.)*([0-9]) ]]; then
            echo "enter number please"
            read row 
            else
            notnumber=false
            fi
        done
        let row=$row+1

        echo "enter the new value"
        read new_value

            notValidData=true
            while $notValidData
                do
                if [[ "$new_value" =~ [\$%^\&*():-_+] ]];then
                    echo -e "${ERRORCOLOR}Cant use speical characters${ENDCOLOR}"
                    echo -e "${ERRORCOLOR}Enter field data again${ENDCOLOR}"
                    read new_value
                fi
                check_type=$(check_datatype $table_name $col $new_value)
                if [[ "$check_type" == 0 ]]; 
                then 
                    echo -e "${ERRORCOLOR}Invalid datatype${ENDCOLOR}"
                    echo -e "${ERRORCOLOR}Enter field data again${ENDCOLOR}"
                    read new_value
                    else
                        check_size=$(check_for_size $table_name $col $new_value)
                        if [[ "$check_size" == 0 ]]
                        then
                            echo -e "${ERRORCOLOR}Invalid dataSize${ENDCOLOR}"
                            echo -e "${ERRORCOLOR}Enter field data again${ENDCOLOR}"
                            read new_value
                        else
                        notValidData=false
                    fi
                fi
            done

        awk -v row=$row -v column=$col -v new_string=$new_value 'BEGIN { FS = OFS = ":" } NR==row{gsub(/.*/,new_string,$column)} 1' $table_name > temp; mv temp $table_name;

        echo -e "${BABYBLUE}Data updated successfully${ENDCOLOR}"
        read
    fi

}
function delete_from_table 
{
    echo -e "Enter Table Name: "
    read table_name
        if ! [[ -f "$table_name" ]]
        then
            sending_output_to_the_user "${ERRORCOLOR}This Table $table_name NOT here, please try again${ENDCOLOR}"
        else
            echo -e "Enter column name: "
            isFieldName "$table_name"
            col=$isFieldName 
            if [[ $col == "" ]]
            then
                sending_output_to_the_user "${ERRORCOLOR}Column NOT here${ENDCOLOR}"
            else
                echo -e "Enter column Value: "
                read value
                value_col=$(awk 'BEGIN{FS=":"}{if ($'$col'=="'$value'") print $'$col'}' $table_name)
                if [[ $value_col == "" ]]
                then
                    sending_output_to_the_user "${ERRORCOLOR}Result NOT here${ENDCOLOR}"
                else
                    Num_Record=$(awk 'BEGIN{FS=":"}{if ($'$col'=="'$value'") print NR}' $table_name 2>>./.error.log) 
                    if ! [[ $Num_Record -eq 1 ]]
                    then
                        sed -i "${Num_Record}d" "$table_name"
                        sending_output_to_the_user "${BABYBLUE}Done, Row Deleted${ENDCOLOR}"
                    fi
                fi
            fi
        fi
}
function display_table
{
    echo -e "Enter name of table"
    read table_name
    if ! [[ -f "$table_name" ]]; then
		echo -e "${ERRORCOLOR}This table doesn't exist${ENDCOLOR}"
		read
    elif [[ $table_name = "" ]];then
        echo -e "${ERRORCOLOR}Enter the name of table please${ENDCOLOR}"
		read
    else
        echo -e "${BABYBLUE}$table_name table${ENDCOLOR}"
        printTable ':' "$(cat $table_name)"
        echo -e "${NEXTLINE}Press enter to continue"
        read
    fi
}
function select_from_table 
{
    echo -e "Enter Table Name: "
    read table_name
        if ! [[ -f "$table_name" ]]
                then
                    sending_output_to_the_user "${ERRORCOLOR}This Table $table_name NOT here, please try again${ENDCOLOR}"
                else
                    echo "Enter Number of ROW That You want to Select it: " 
                    read row
                        if [[ "$row" == '' || "$row" == 0 ]]
                            then
                                sending_output_to_the_user "${ERRORCOLOR}This value NOT here${ENDCOLOR}"
                            else    
                            let row=$row+1
                            printTable ':' "$(awk 'BEGIN{ FS = "-"} {if(NR=='$row') print $0}' $table_name)"
                            read

                        fi
        fi
}