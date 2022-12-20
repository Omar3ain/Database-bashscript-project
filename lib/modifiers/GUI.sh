function sending_error 
{
    zenity --error \
            --title "Error Message" \
            --width 300 \
            --height 100 \
            --text "$1";
}
function get_input_gui
{
    zenity --entry \
       --width 500 \
       --height 100 \
       --title "$1" \
       --text "$2"
}
function make_warning_gui
{
    zenity --warning --width 500 --height 100 --title="$1" --text="$2"
}

function info_massage
{

enity --info \
       --title "$1" \
       --width 500 \
       --height 100 \
       --text "$2"

}
function display_table_gui
{
    new='';
    number_of_fields=$(head -1 "$1" | awk -F: '{print NF}') ;
    for (( i = 1; i <= number_of_fields; i++ ));
        do
            temp=$(head -1 $1 | cut -d ":" -f"$i" | awk -F "-" 'BEGIN { RS = ":" } {print $1}' | tr '[:lower:]' '[:upper:]');
            new=$new" --column="$temp"";
        done
        
   result=$(tail -n +2 "$1" |tr ':' '\n' | zenity --list --title="Displaying table" --text=""$new 2>/dev/null)
}
function select_from_table_gui
{
    new='';
    number_of_fields=$(head -1 "$1" | awk -F: '{print NF}') ;
    for (( i = 1; i <= number_of_fields; i++ ));
        do
            temp=$(head -1 $1 | cut -d ":" -f"$i" | awk -F "-" 'BEGIN { RS = ":" } {print $1}' | tr '[:lower:]' '[:upper:]');
            new=$new" --column="$temp"";
        done
        result=$(head -n $2 "$1" | tail -n +$2 |tr ':' '\n' | zenity --list --title="Result of selecting the table" --text=""$new 2>/dev/null)
}
