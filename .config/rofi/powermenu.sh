#!/bin/bash
 
lock=" Lock"
logout=" Logout"
shutdown="襤 Poweroff"
reboot=" Reboot"
sleep=" Suspend"
reloadSxhkd=" Reload sxhkd config"
reloadBspwm=" Reload bspwm"
reloadWacomRes="Wacom - Tablet Position" 
wacomSingleMonitor="Wacom - Single Monitor"

selected_option=$(echo "$lock
$logout
$sleep
$reboot
$shutdown
$reloadSxhkd
$reloadBspwm
$reloadWacomRes
$wacomSingleMonitor" | rofi -dmenu -i -p "Powermenu" \
		  -theme "~/.config/rofi/powermenu.rasi")

if [ "$selected_option" == "$lock" ]; then
	# insert lock command here
	notify-send "fisk"
elif [ "$selected_option" == "$logout" ]; then
	bspc quit
elif [ "$selected_option" == "$shutdown" ]; then
	systemctl poweroff
elif [ "$selected_option" == "$reboot" ]; then
	systemctl reboot
elif [ "$selected_option" == "$sleep" ]; then
	systemctl suspend
elif [ "$selected_option" == "$reloadSxhkd" ]; then
	pkill -USR1 -x sxhkd
elif [ "$selected_option" == "$reloadBspwm" ]; then
	bspc wm -r
elif [ "$selected_option" == "$reloadWacomRes" ]; then
	source ~/.config/sxhkd/scripts/wacomPosition.sh
elif [ "$selected_option" == "$wacomSingleMonitor" ]; then
	xrandr --output DVI-D-0 --mode 1920x1080 --pos 960x2160
	sleep 1
	xsetwacom set 'Wacom One Pen Display 13 Pen stylus' MapToOutput $(xrandr | grep DVI-D |awk '{ print $3 }')
	nitrogen --restore
else
  echo "No match"
fi
