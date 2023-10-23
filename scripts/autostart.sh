#!/bin/bash

WALLPAPER="$HOME/.wallpapers/8K/dunes.jpg"


##########################################
#	   protocol independent		 #
##########################################

kmonad ~/.config/kmonad/t14g3.kbd &

# notifications
/usr/bin/dunst &

#polkit
/usr/lib/polkit-kde-authentication-agent-1 &

##########################################
#	   	X Server		 #
##########################################
if [ "$XDG_SESSION_TYPE" = "x11" ]; then

  # display settings
  #xrandr --output DP-0 --primary --mode 3840x2160 --rate 144  --pos 0x0 --rotate normal --output HDMI-0 --mode 1920x1080 --rate 60 --rotate right --right-of DP-0 

  # keyboard layout
  setxkbmap eu 

  # sets arrowshape
  xsetroot -cursor_name left_ptr 

  # wallpaper
  nitrogen --set-zoom-fill $WALLPAPER &

  polybar &

##########################################
#	   	Wayland			 #
##########################################
elif [ "$XDG_SESSION_TYPE" = "wayland" ]; then

  swaybg -i $WALLPAPER &

  waybar &

  #wl-paste --type text --watch cliphist store #Stores only text data
  #wl-paste --type image --watch cliphist store #Stores only image data
fi
