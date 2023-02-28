#!/bin/bash

startWidth=$(bspc query -T -n | jq .rectangle.width)
startHeight=$(bspc query -T -n | jq .rectangle.height)



# calculate the difference between the current window width and the desired width of 1920 pixels
widthDifference=$((1920 - $startWidth))

if [ $widthDifference -lt 0 ]; then
    notify-send "Window is wider than desired width by '$widthDifference' pixels."
    bspc node --resize left $(($widthDifference * -1)) 0
    if [ $? -ne 0 ]; then
    # if it failed, execute the second command
    bspc node --resize right $widthDifference 0
    fi

  # execute the first command
else

  notify-send "Window is narrower than desired width by $widthDifference pixels."

  bspc node --resize left $(($widthDifference * -1)) 0
    if [ $? -ne 0 ]; then
    # if it failed, execute the second command
    bspc node --resize right $widthDifference 0
    fi

fi

# calculate the difference between the current window width and the desired width of 1920 pixels
heightDifference=$((1080 - $startHeight))

if [ $heightDifference -lt 0 ]; then
    notify-send "Window is higher than desired width by '$heightDifference' pixels."
    bspc node --resize top 0 $(($heightDifference * -1))
    if [ $? -ne 0 ]; then
    # if it failed, execute the second command
    bspc node --resize bottom 0 $heightDifference
    fi

  # execute the first command
else

  notify-send "Window is lower than desired width by $heightDifference pixels."

  bspc node --resize top 0 $(($heightDifference * -1))
    if [ $? -ne 0 ]; then
    # if it failed, execute the second command
    bspc node --resize bottom 0 $heightDifference
    fi

fi

sleep 1
xPos=$(bspc query -T -n | jq .rectangle.x)
yPos=$(bspc query -T -n | jq .rectangle.y)

xrandr --output DVI-D-0 --mode 1920x1080 --pos "$(($xPos))"x"$yPos"
sleep 1

xsetwacom set "Wacom One Pen Display 13 Pen stylus" MapToOutput 1920x1080+$xPos+$yPos