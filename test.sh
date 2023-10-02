#!/bin/bash

sudo pacman -Syu

# X11 related
sudo pacman -S git base-devel xorg-server xorg-xinit libx11 libxft

# Other
sudo pacman -S alacritty

echo 'finished added packages'


# Bytt ut med egen
git clone https://github.com/Stianlyng/archinstall.git
cd archinstall/dwm
make clean install

echo 'successfully installed dwm'
cd ~/

# Copying
cp archinstall/xinitrc ~/.xinitrc

