#!/bin/bash

# add dotfiles 
cp -r config/* ~/.config # Copy config folder 
cp .xinitrc ~/.xinitrc

# Update and install essentials
sudo pacman -Syu --noconfirm base-devel git ranger neovim terminus-font zsh ly fish alacritty firefox pcmanfm xorg-server xorg-xinit libx11 libxft libxinerama dmenu xclip

# Enable ly display manager
sudo systemctl enable ly

# Change default shell
chsh -s /bin/fish

# Install dwm
cd dwm
sudo make clean install

echo 'End of script!'
