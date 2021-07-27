#menu to load multiple roms using whiptail
#seperate functions to load via seperate emus
#load nestopia roms
installed_nes(){
PS3="Enter Choice: "
echo "Please select a rom."
select file ; do
  [ "$file" ] &&
   {
     echo "Opening $file"
     nestopia $file
        break
   } ||
   {
     echo "bad choice"
     break
   }
done
}

#load GBA roms
function installed_gba()
{
PS3="Enter Choice: "
echo "Please select a rom."
select file ; do
  [ "$file" ] &&
   {
     echo "Opening $file"
        VisualBoyAdvance -F  $file
        break
   } ||
   {
     echo "bad choice"
     break
   }
done
}
function initialize()
        {
	sudo apt install visualboyadvance nestopia -y
        {
	rm -rf *nes* *gba*
        if cat romlist
        then
        advancedMenu
        else
        clear
        echo "romlist does not exist please add direct download links to file"
	sleep 5
	nano romlist
	advancedMenu
        fi
        }
        wget -i romlist
        #sanitize
        for file in *; do mv "$file" $(echo "$file" | tr ' ' '_') ; done
        #unzip
        for i in $(ls *.7z); do 7za e "$i" ; done
        #clean
        rm -rf *7z*
        #resanitize
        for file in *; do mv "$file" $(echo "$file" | tr ' ' '_') ; done
	advancedMenu
        }



function advancedMenu() {
    ADVSEL=$(whiptail --title "Rom Browser" --fb --menu "Choose an option" 15 60 4 \
        "1" "NES Roms" \
        "2" "GBA Roms" \
        "3" "Check for Updates" 3>&1 1>&2 2>&3)
    case $ADVSEL in
        1)
        clear
        installed_nes $(ls *.nes)
        ;;
        2)
        clear
        installed_gba $(ls *.gba)
        ;;
        3)
        clear
        initialize
        echo "Roms Downloaded!"
        advancedMenu
        ;;

    esac
}
advancedMenu
