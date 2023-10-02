#!/bin/bash

sudo pacman -Syu

# X11 related
sudo pacman -S git base-devel xorg-server xorg-xinit libx11 libxft

# Other
sudo pacman -S alacritty

# Bytt ut med egen
git clone git@github.com:Stianlyng/archinstall.git
cd archinstall/dwm
make clean install

cd ~/

# Copying
cp archinstall/xinitrc ~/.xinitrc

