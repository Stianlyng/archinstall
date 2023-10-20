#!/bin/bash

# Update and install essentials
sudo pacman -Syu --noconfirm base-devel terminus-font xorg-server xorg-xinit libx11 libxft libxinerama dmenu xclip

sudo mkdir /usr/share/xsessions
sudo cp dwm/dwm.desktop /usr/share/xsessions/dwm.desktop

cd dwm
sudo make clean install

echo 'End of script!'
