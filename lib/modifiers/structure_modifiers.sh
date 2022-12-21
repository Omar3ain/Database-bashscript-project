#!/bin/bash
function divider 
{
    echo -e "**************************************************************************"
}
function invalid_list_input_handle
{
    echo -e "${ERRORCOLOR}Please choose from the list${ENDCOLOR}"
    echo press any key
    read
}
function sending_output_to_the_user 
{
    echo -e $1
    echo "Press any key to continue"
    read  
}
function get_input
{
    notValidData=true
    while $notValidData
    do
    READ=$(get_input_gui "Table data" "$1");
        if [[ $READ = "" ]]; 
        then
            sending_error "Invalid Input, please enter a valid one"
        elif [[ $READ =~ [/.:\|\-] ]]; then
            sending_error "You can't enter these characters => . / : - | $"
        elif [[ $READ =~ ^[a-zA-Z] ]]; then
            echo -n "$READ" >> "$table_name"
            echo -n "-" >> "$table_name"
            notValidData=false
        else
            sending_error "field name can't start with numbers or special characters"
        fi
    done
}
function validData
{
    if [[ $1 = "" ]]; 
        then
            echo -e "${ERRORCOLOR}Invalid Input, please enter a valid one${ENDCOLOR}"
            read
        elif [[ $1 =~ [/.:\|\-] ]]; then
            echo -e "${ERRORCOLOR}You can't enter these characters => . / : - | ${ENDCOLOR}"
            read
        fi
}
function is_primary_key 
{
					if [[ $1 -eq 1 ]]; then
						echo -n "PK" >> "$table_name"
						echo -n "-" >> "$table_name"
					else
                        echo -n "NotPK" >> "$table_name"
						echo -n "-" >> "$table_name"
					fi
}
function get_data_size
{
        notValidData=true
        while $notValidData; do
        READ=$(get_input_gui "Table data" "Enter column size")
        if [[ "$READ" = +([1-9])*([0-9]) ]]; then
            echo -n "$READ" >> "$table_name"
            echo -n "-" >> "$table_name"
            notValidData=false
        else
            sending_error  "Enter valid number please"
        fi
    done
}
function get_data_type
{
    if [[ $1 -eq 1 ]]; then
	echo -n "integer" >> "$table_name"
    else
    notValidData=true
    while $notValidData;
    do
        asnwer=$(zenity --list \
                    --title="Table data" \
                    --text "What is the datatype of that column ?" \
                    --radiolist \
                    --column "Pick" \
                    --column "Answer" \
                    FALSE "integer" \
                    FALSE "string");
                    if [[ $asnwer == '' ]];then
                    sending_error "Must enter datatype"
                    else
                    echo -n "$asnwer" >> "$table_name"
                    notValidData=false
                    fi
                done
    fi
    

}
function check_datatype
{
    datatype=$(head -1 $1 | cut -d ':' -f$2| awk -F "-" 'BEGIN { RS = ":" } {print $4}')
	if [[ "$3" = '' ]]; then
		echo 1
	elif [[ "$3" = -?(0) ]]; then
		echo 0 
	elif [[ "$3" = ?(-)+([0-9])?(.)*([0-9]) ]]; then
		if [[ $datatype == integer ]]; then
			echo 1
		else
			echo 0
		fi
	else
		if [[ $datatype == integer ]]; then
			echo 0 
		else
			echo 1
		fi
	fi
}
function check_for_size 
{
    dataSizeCheck=$(head -1 $1 | cut -d ':' -f$2| awk -F "-" 'BEGIN { RS = ":" } {print $3}')

   length=$(expr length "$3")

	if [[ $length -le $dataSizeCheck ]] 
    then
		echo 1
	else
		echo 0
	fi
}
function isFieldName
{
    notFieldName=true
    columns=$(head -1 "$1" | awk 'BEGIN{ RS = ":"; FS = "-" } {print $1}')

        field_name=$(get_input_gui "Type column name you want to change its data please")
        if [[ $(echo "$columns" | grep -x "$field_name") = "" ]]; then
            sending_error "That field does not exsist"
        else
            isFieldName=$(head -1 "$1" | awk 'BEGIN{ RS = ":"; FS = "-" } {print $1}'| grep -x -n $field_name | cut -d: -f1)
            export isFieldName
        fi
}

