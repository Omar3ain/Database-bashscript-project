function divider 
{
    echo -e "${NEXTLINE}+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++${NEXTLINE}"
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
    echo press any key
    read  
}
function get_input
{
    notValidData=true
    while $notValidData
    do
    echo $1
    read 
        if [[ $REPLY = "" ]]; 
        then
            echo -e "${ERRORCOLOR}Invalid Input, please enter a valid one${ENDCOLOR}"

        elif [[ $REPLY =~ [/.:\|\-] ]]; then
            echo -e "${ERRORCOLOR}You can't enter these characters => . / : - | ${ENDCOLOR}"
        elif [[ $REPLY =~ ^[a-zA-Z] ]]; then
            echo -n "$REPLY" >> "$table_name"
            echo -n "-" >> "$table_name"
            notValidData=false
        else
            echo -e "${ERRORCOLOR}field name can't start with numbers or special characters${ENDCOLOR}"
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
        echo -e "Enter column size"
        read 
        if [[ "$REPLY" = +([1-9])*([0-9]) ]]; then
            echo -n "$REPLY" >> "$table_name"
            echo -n "-" >> "$table_name"
            notValidData=false
        else
            echo -e "\e[41minvalid entry\e[0m"
        fi
    done
}
function get_data_type
{
    notValidData=true
    while $notValidData; do
            echo -e "Enter column type"
            select choice in "integer" "string"; do
                if [[ "$REPLY" = "1" || "$REPLY" = "2" ]]; then
                    echo -n "$choice" >> "$table_name"
                    notValidData=false
                else
                    echo -e "${ERRORCOLOR}invalid choice${ENDCOLOR}"
                fi
                break
            done
        done
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
	if [[ "${#3}" -le $dataSizeCheck ]] 
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
    while $notFieldName 
        do
        read field_name
        if [[ $(echo "$columns" | grep -x "$field_name") = "" ]]; then
            echo -e "${ERRORCOLOR}That field does not exsist${ENDCOLOR}"
            echo -e "${ERRORCOLOR}Enter the field name again${ENDCOLOR}"
        else
            isFieldName=$(head -1 "$1" | awk 'BEGIN{ RS = ":"; FS = "-" } {print $1}'| grep -x -n $field_name | cut -d: -f1)
            export isFieldName
            notFieldName=false
        fi
    done
}

