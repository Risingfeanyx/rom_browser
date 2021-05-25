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



function advancedMenu() {
    ADVSEL=$(whiptail --title "Rom Browser" --fb --menu "Choose an option" 15 60 4 \
        "1" "NES Roms" \
        "2" "GBA Roms" \
        "3" "Check for Updates" 3>&1 1>&2 2>&3)
    case $ADVSEL in
        1)
        clear
        installed_nes ~/emulator_download/roms/nes/*
        ;;
        2)
        clear
        installed_gba ~/emulator_download/roms/gba/*
        ;;
        3)
            echo "Option 3"
            whiptail --title "Option 1" --msgbox "You chose option 3. Exit status $?" 8 45
        ;;
    esac
}
advancedMenu
