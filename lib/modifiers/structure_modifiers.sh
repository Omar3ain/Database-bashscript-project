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