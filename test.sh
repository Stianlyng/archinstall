#!/bin/bash

sudo pacman -Syu

# X11 related
sudo pacman -S --noconfirm git base-devel xorg-server xorg-xinit libx11 libxft

# Other
sudo pacman -S --noconfrim alacritty ranger neovim

echo 'finished added packages'


# Bytt ut med egen
cd archinstall/dwm
make clean install

echo 'successfully installed dwm'
cd ~/

# Copying
cp archinstall/xinitrc ~/.xinitrc

