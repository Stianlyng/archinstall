#!/bin/sh

while true
do
    xsetroot -name "$(date) $(uptime | sed 's/.*,//')"
    sleep 1
done &
exec dwm
