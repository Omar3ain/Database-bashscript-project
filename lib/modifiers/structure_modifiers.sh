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
            echo -e "\e[41mfield name can't start with numbers or special characters\e[0m"
        fi
    done
}
function is_primary_key 
{
    notValidData=true
    while $notValidData; do
				echo -e "Is it primary key?"
				select choice in "Yes" "No"; do
					if [[ "$REPLY" = "1" || "$REPLY" = "y" ]]; then
						echo -n "PrimaryKey" >> "$table_name"
						echo -n "-" >> "$table_name"
						notValidData=false
                    elif [[ "$REPLY" = "2" || "$REPLY" = "n" ]]; then
                        notValidData=false
					else
						echo -e "${ERRORCOLOR}invalid input${ENDCOLOR}"
					fi
					break
				done
			done
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