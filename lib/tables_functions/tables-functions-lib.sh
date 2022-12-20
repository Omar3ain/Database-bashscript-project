#!/bin/bash
function table_page_title
{
    echo -e "${LIGHTGREY}${BLACK}----------------------------------------------------------------------------------------${ENDCOLOR}"
    echo -e "${LIGHTGREY}${BLACK}|                                                                                      |${ENDCOLOR}"
    echo -e "${LIGHTGREY}${BLACK}|                                                                                      |${ENDCOLOR}"
    echo -e "${LIGHTGREY}${BLACK}|                                                                                      |${ENDCOLOR}"
    echo -e "${LIGHTGREY}${BLACK}|                    WELCOME TO TABLES PAGE OF DATABASE '${dbName}'                     |${ENDCOLOR}"
    echo -e "${LIGHTGREY}${BLACK}|                                                                                      |${ENDCOLOR}"
    echo -e "${LIGHTGREY}${BLACK}|                                                                                      |${ENDCOLOR}"
    echo -e "${LIGHTGREY}${BLACK}|                                                                                      |${ENDCOLOR}"  
    echo -e "${LIGHTGREY}${BLACK}----------------------------------------------------------------------------------------${ENDCOLOR}"
    echo
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
                (
                echo 10
                echo "# Back to Database page"
                sleep 2

                echo 100
                echo "# Database page loading completed!"
                ) | zenity --title "Database page Loading Progress Bar" --progress --auto-close --width="600"
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
    table_name=$(get_input_gui "Table name" "Enter the table name please");
        ret=$?
        if ! [[ "$ret" == 0 ]] || [[ "$table_name" == '' ]]; then
            return
        fi
	if [[ $table_name = "" ]]
        then
            sending_output_to_the_user "${ERRORCOLOR}Cant create a table without a name${ENDCOLOR}"
	elif [[ -e $table_name ]] 
        then
            sending_output_to_the_user "${ERRORCOLOR}This table name is already exsists${ENDCOLOR}"
    elif [[ $table_name =~ [/] ]] 
        then
            sending_output_to_the_user "${ERRORCOLOR}Can't use / in naming the table${ENDCOLOR}"
    elif [[ $table_name =~ [.:\|\-] ]] 
        then
            sending_output_to_the_user "${ERRORCOLOR}Can't use special character in naming the table${ENDCOLOR}"
    elif [[ $table_name =~ [1-9] ]] 
        then
            sending_output_to_the_user "${ERRORCOLOR}Can't use Numbers in naming the table${ENDCOLOR}"        
	elif [[ $table_name =~ ^[a-zA-Z] ]] 
        then
            touch $table_name
            table_fields;
            notify-send "Table status" "Table Created successfully."
	fi
}
function table_fields 
{
    number_of_columns=$(get_input_gui "Table data" "Enter number of columns please");
        ret=$?
        if ! [[ "$ret" == 0 ]] || [[ "$table_name" == '' ]]; then
            return
        fi
        notValidNumber=true
        while $notValidNumber 
        do
        if ! [[ "$number_of_columns" = +([1-9])*([0-9]) ]]; then
            sending_error "Enter valid number please.";
            number_of_columns=$(get_input_gui "Table data" "Enter valid number of columns please");
        elif [[ "$number_of_columns" -gt 25 ]]; then
            sending_error "Can't be that big number of columns.";
            number_of_columns=$(get_input_gui "Table data" "Enter valid number of columns please");
        else
            notValidNumber=false
        fi
        done

        for (( i = 1; i <= number_of_columns; i++ ));
        do
            if [[ i -eq 1 ]]; then
                get_input "Enter primary column name of type integer:"
            else
                get_input "Enter column number $[i] name:" 
            fi
            is_primary_key $i;
            get_data_size;
            get_data_type $i;
            
            if ! [[ i -eq $number_of_columns ]]
            then
            echo -n ":" >> "$table_name"
            fi
        done
        echo >> "$table_name"
}
function drop_table 
{
    if [ -z "$(ls -A . )" ]; then
        make_warning_gui "Warning" "No tables available"
        else
        table_name=$(zenity --title="Tables available" --text="" --list --column="Tables in that database" $(ls))
        ret=$?
        if ! [[ "$ret" == 0 ]] || [[ "$table_name" == '' ]]; then
            return
        fi
        rm "$table_name"
		notify-send "Table status" "Table removed successfully."
        fi
}
function list_tables 
{
        if [ -z "$(ls -A . )" ]; then
        make_warning_gui "Warning" "No tables available"
        else
        zenity --title="Tables available" --text="" --list --column="Tables in that database" $(ls)
        fi
    
}
function insert_into_table
{
    if [ -z "$(ls -A . )" ]; then
        make_warning_gui "Warning" "No tables available"
        else
        table_name=$(zenity --title="Tables available" --text="" --list --column="Tables in that database" $(ls));
        ret=$?
        if ! [[ "$ret" == 0 ]] || [[ "$table_name" == '' ]]; then
            return
        fi

         number_of_fields=$(head -1 "$table_name" | awk -F: '{print NF}') ;

        for (( i = 1; i <= number_of_fields; i++ ));
        do
            notValidData=true
            while $notValidData
            do
            READ=$(get_input_gui "Data entry" "Enter field $[i] data:")
            check_type=$(check_datatype $table_name $i $READ)
            check_size=$(check_for_size $table_name $i $READ)
            primarynumber=$(cut -d ':' -f1 $table_name | awk '{if(NR != 1) print $0}' | grep -x -e "$READ") 
            if [[ "$check_type" == 0 ]];then
                sending_error "Invalid datatype"
            elif [[ "$check_size" == 0 ]];then
                sending_error "Invalid datasize"
            elif [[ $READ =~ [/.:\|\-] ]];then
                sending_error  "Invalid input"
            elif [[ "$READ" == '' ]] || ! [[ "$primarynumber" == '' ]] || [[ "$READ" =~ ^" " ]] || [[ $i -eq 1 && "$READ" =~ " " ]] ;then
                sending_error "Either you entered blank input or used Primary key"
            else
            notValidData=false
            fi
            done

            if [[ i -eq $number_of_fields ]] 
            then
                echo "$READ" >> "$table_name"
                else
                echo  -n "$READ": >> "$table_name"
            fi
        done
        notify-send "Table status" "Data Inserted successfully."
        fi

}
function update_table 
{
    if [ -z "$(ls -A . )" ]; then
        make_warning_gui "Warning" "No tables available"
        else
        table_name=$(zenity --title="Tables available" --text="" --list --column="Tables in that database" $(ls));
        
        ret=$?
        if ! [[ "$ret" == 0 ]] || [[ "$table_name" == '' ]]; then
            return
        fi


        isFieldName "$table_name"
        col=$isFieldName

        notnumber=true
        while $notnumber 
            do
            row=$(get_input_gui "Update table" "Type row number you want to update please")
            if [[ $row =~ ^[0-9]+$ ]]; then
            notnumber=false
            else
            sending_error "Enter number please"
            fi
        done
        let row=$row+1


            notValidData=true
            while $notValidData
            do
            READ=$(get_input_gui "Update table" "enter the new value")
            check_type=$(check_datatype $table_name $col $READ)
            check_size=$(check_for_size $table_name $col $READ)
            primarynumber=$(cut -d ':' -f1 $table_name | awk '{if(NR != 1) print $0}' | grep -x -e "$READ") 
            if [[ "$check_type" == 0 ]];then
                sending_error "Invalid datatype"
            elif [[ "$check_size" == 0 ]];then
                sending_error "Invalid datasize"
            elif [[ $READ =~ [/.:\|\-] ]];then
                sending_error  "Invalid input"
            elif [[ "$READ" == '' ]] || ! [[ "$primarynumber" == '' ]] || [[ "$READ" =~ ^" " ]] || [[ $i -eq 1 && "$READ" =~ " " ]] ;then
                sending_error "Either you entered blank input or used Primary key"
            else
            notValidData=false
            fi
            done

        awk -v row=$row -v column=$col -v new_string=$READ 'BEGIN { FS = OFS = ":" } NR==row{gsub(/.*/,new_string,$column)} 1' $table_name > temp; mv temp $table_name;

        notify-send "Table status" "Data Updated successfully."
        fi
}
function delete_from_table 
{
    if [ -z "$(ls -A . )" ]; then
        make_warning_gui "Warning" "No tables available"
        else
        table_name=$(zenity --title="Tables available" --text="" --list --column="Tables in that database" $(ls));
        
        ret=$?
        if ! [[ "$ret" == 0 ]] || [[ "$table_name" == '' ]]; then
            return
        fi
                value=$(get_input_gui "Delete from table" "Enter primary key column Value: ");
                
                if [[ $value == "" ]]
                then
                    sending_error "This Result $value NOT here, please try again"
                elif ! [[ "$value" = ?(-)+([0-9])?(.)*([0-9]) ]]; then
                    sending_error "Must be number"
                else
                    Num_Record=$(awk 'BEGIN{FS=":"}{if ($1=="'$value'") print NR}' $table_name  2>/dev/null);
                    if ! [[ $Num_Record -eq 1 ]] && [[ -n $Num_Record ]];
                    then
                        sed -i "${Num_Record}d" "$table_name"
                        notify-send "Table status" "Row Deleted successfully."
                    fi
            fi
        fi
}
function display_table
{

        if [ -z "$(ls -A . )" ]; then
        make_warning_gui "Warning" "No tables available"
        else
            table_name=$(zenity --title="Tables available" --text="" --list --column="Tables in that database" $(ls));
            ret=$?
            if ! [[ "$ret" == 0 ]] || [[ "$table_name" == '' ]]; then
                return
            fi
                display_table_gui "$table_name"
        fi
}
function select_from_table 
{
    if [ -z "$(ls -A . )" ]; then
            make_warning_gui "Warning" "No tables available"
        else
            table_name=$(zenity --title="Tables available" --text="" --list --column="Tables in that database" $(ls));
            ret=$?
            if ! [[ "$ret" == 0 ]] || [[ "$table_name" == '' ]]; then
                return
            fi
            row=$(get_input_gui "Select from table" "Enter Number of ROW That You want to Select it: ")
            if [[ "$row" == '' || "$row" == 0 ]]
            then
                sending_error "This value NOT here"
            else    
                let row=$row+1
                select_from_table_gui "$table_name" "$row"
            fi
        fi
}