#!/bin/bash

# add dotfiles 
cp -r config/* ~/.config # Copy config folder 
cp .xinitrc ~/.xinitrc

# Update and install essentials
sudo pacman -Syu 
sudo pacman -S --noconfirm base-devel git ranger neovim terminus-font zsh ly fish alacritty firefox pfmanfm xorg-server xorg-xinit libx11 libxft libxinerama dmenu

# Enable ly display manager
sudo systemctl enable ly

# Change default shell
chsh -s /bin/fish

# Install dwm
cd dwm
sudo make clean install

echo 'End of script!'
