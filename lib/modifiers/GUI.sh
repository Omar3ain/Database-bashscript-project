function sending_error 
{
    zenity --error \
            --title "Error Message" \
            --width 500 \
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