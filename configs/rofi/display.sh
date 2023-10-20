#!/bin/bash
 
lock=" Lock"
logout=" Logout"
shutdown="襤 Poweroff"
reboot=" Reboot"
sleep=" Suspend"
reloadSxhkd=" Reload sxhkd config"
reloadBspwm=" Reload bspwm"
 
selected_option=$(echo "$lock
$logout
$sleep
$reboot
$shutdown
$reloadSxhkd
$reloadBspwm" | rofi -dmenu -i -p "Powermenu" \
		  -theme "~/.config/rofi/powermenu.rasi")

if [ "$selected_option" == "$lock" ]
then
	# insert lock command here
	notify-send "fisk"
elif [ "$selected_option" == "$logout" ]
then
	bspc quit
elif [ "$selected_option" == "$shutdown" ]
then
 systemctl poweroff
elif [ "$selected_option" == "$reboot" ]
then
  systemctl reboot
elif [ "$selected_option" == "$sleep" ]
then
  systemctl suspend
elif [ "$selected_option" == "$reloadSxhkd" ]
then
  pkill -USR1 -x sxhkd
elif [ "$selected_option" == "$reloadBspwm" ]
then
  bspc wm -r
else
  echo "No match"
fi
