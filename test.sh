#!/bin/bash

sudo pacman -Syu

sudo pacman -S git base-devel xorg-server xorg-xinit libx11 libxft

# Bytt ut med egen
git clone git://git.suckless.org/dwm
cd dwm
make clean install

cd 

# Starting dwm automatically

cat > ~/.xinitrc <<'EOF'
while true
do
    xsetroot -name "$(date) $(uptime | sed 's/.*,//')"
    sleep 1
done &
exec dwm
EOF