#!/bin/bash
 
#theme="$HOME/.local/share/rofi/themes/SOMETHING"

title="Screenshot menu"
selClip="Selection -> clipboard"
selSave="Selection -> Save"

# save file
file="/home/stian/screenshots/screenshot-$(date +%F_%T).png"

    selected_option=$(echo "$selClip
$selSave" | rofi -dmenu -i -p "$title")
#$selSave" | rofi -dmenu -i -p "$title" -theme $theme)

 

if [ "$selected_option" == "$selClip" ]
then
   sleep 1 && scrot -s "$file"
   sleep 1 && xclip -sel clip -t image/png $file
   sleep 1 && rm $file
elif [ "$selected_option" == "$selSave" ]
then
   sleep 1 && scrot -s "$file"
else
  echo "No match"
fi
