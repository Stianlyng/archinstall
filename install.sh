#!/bin/bash

# add dotfiles 
cp -r config/* ~/.config # Copy config folder 
cp .xinitrc ~/.xinitrc
sudo mkdir /usr/share/xsessions
sudo cp dwm/dwm.desktop /usr/share/xsessions/dwm.desktop

# Update and install essentials
sudo pacman -Syu --noconfirm base-devel git ranger neovim terminus-font zsh ly fish alacritty pcmanfm xorg-server xorg-xinit libx11 libxft libxinerama dmenu xclip tldr bspwm sxhkd 

# Browser + python-adblock dependency needed for adblock
sudo pacman -Syu --noconfirm qutebrowser python-adblock firefox

# Enable ly display manager
sudo systemctl enable ly

# Change default shell
chsh -s /bin/fish

# Install dwm
cd dwm
sudo make clean install

echo 'End of script!'
