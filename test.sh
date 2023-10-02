#!/bin/bash

sudo pacman -Syu

# X11 related
sudo pacman -S --noconfirm git base-devel xorg-server xorg-xinit libx11 libxft libxinerama

# Other
sudo pacman -S --noconfirm alacritty ranger neovim 

echo 'finished added packages'

# Bytt ut med egen
git clone https://github.com/Stianlyng/archinstall.git
cd archinstall/dwm
sudo make clean install

echo 'successfully installed dwm'
cd ~/

# Copying
cp archinstall/xinitrc ~/.xinitrc

