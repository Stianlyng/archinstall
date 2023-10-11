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
dimDesktoplight="Hue - Dim desktop light"
turnOffDesktopLight="Hue - Turn off desktop light"
brightDesktopLight="Hue - 100% brightness desktop light"
turnOfflights="Hue - Turn off lights"
turnOnLights="Hue - Turn on lights"

selected_option=$(echo "$lock
$logout
$sleep
$reboot
$shutdown
$reloadSxhkd
$reloadBspwm
$reloadWacomRes
$wacomSingleMonitor
$dimDesktoplight
$turnOffDesktopLight
$brightDesktopLight
$turnOfflights
$turnOnLights" | rofi -dmenu -i -p "Commandpalette" \
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
elif [ "$selected_option" == "$dimDesktoplight" ]; then
	curl -X PUT -H "Content-Type: application/json" -d '{"on":true, "sat":254, "bri":50,"hue":10000}' "192.168.1.57/api/govhnBiTPe8iX8ELInC3k3aaOHyCHT5BNmicHAei/lights/14/state"
elif [ "$selected_option" == "$turnOffDesktopLight" ]; then
	curl -X PUT -H "Content-Type: application/json" -d '{"on":false}' "192.168.1.57/api/govhnBiTPe8iX8ELInC3k3aaOHyCHT5BNmicHAei/lights/14/state"
elif [ "$selected_option" == "$brightDesktopLight" ]; then
	curl -X PUT -H "Content-Type: application/json" -d '{"on":true, "sat":117, "bri":254,"hue":15413}' "192.168.1.57/api/govhnBiTPe8iX8ELInC3k3aaOHyCHT5BNmicHAei/lights/14/state"
elif [ "$selected_option" == "$turnOfflights" ]; then
	curl -X PUT -H "Content-Type: application/json" -d '{"on":false}' "192.168.1.57/api/govhnBiTPe8iX8ELInC3k3aaOHyCHT5BNmicHAei/lights/11/state"
	curl -X PUT -H "Content-Type: application/json" -d '{"on":false}' "192.168.1.57/api/govhnBiTPe8iX8ELInC3k3aaOHyCHT5BNmicHAei/lights/12/state"
	curl -X PUT -H "Content-Type: application/json" -d '{"on":false}' "192.168.1.57/api/govhnBiTPe8iX8ELInC3k3aaOHyCHT5BNmicHAei/lights/13/state"
	curl -X PUT -H "Content-Type: application/json" -d '{"on":false}' "192.168.1.57/api/govhnBiTPe8iX8ELInC3k3aaOHyCHT5BNmicHAei/lights/14/state"
elif [ "$selected_option" == "$turnOnLights" ]; then
	curl -X PUT -H "Content-Type: application/json" -d '{"on":true, "sat":117, "bri":254,"hue":15413}' "192.168.1.57/api/govhnBiTPe8iX8ELInC3k3aaOHyCHT5BNmicHAei/lights/11/state"
	curl -X PUT -H "Content-Type: application/json" -d '{"on":true, "sat":117, "bri":254,"hue":15413}' "192.168.1.57/api/govhnBiTPe8iX8ELInC3k3aaOHyCHT5BNmicHAei/lights/12/state"
	curl -X PUT -H "Content-Type: application/json" -d '{"on":true, "sat":117, "bri":254,"hue":15413}' "192.168.1.57/api/govhnBiTPe8iX8ELInC3k3aaOHyCHT5BNmicHAei/lights/13/state"
	curl -X PUT -H "Content-Type: application/json" -d '{"on":true, "sat":117, "bri":254,"hue":15413}' "192.168.1.57/api/govhnBiTPe8iX8ELInC3k3aaOHyCHT5BNmicHAei/lights/14/state"
#elif [ "$selected_option" == "$" ]; then
#elif [ "$selected_option" == "$" ]; then
#elif [ "$selected_option" == "$" ]; then
#elif [ "$selected_option" == "$" ]; then
else
  echo "No match"
fi