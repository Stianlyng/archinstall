#!/bin/bash

sudo pacman -Syu 

# Install essentials
sudo pacman -S --noconfirm base-devel git ranger neovim terminus-font

# Clone dotfiles and configs
git clone https://github.com/Stianlyng/archinstall.git

read -p "Do you want to use dwm window manager? [Y/n] " response

case "$response" in
    [yY][eE][sS]|[yY])
        echo "You chose yes."
        
        # Install dwm dependencies and other software
        sudo pacman -S --noconfirm xorg-server xorg-xinit libx11 libxft libxinerama alacritty

        # Install dwm
        cd archinstall/dwm
        sudo make clean install
        echo 'Successfully installed dwm'
        cd ~/
        cp archinstall/xinitrc ~/.xinitrc
        ;;
    [nN][oO]|[nN])
        echo "You chose no."
        ;;
    *)
        echo "Invalid response."
        ;;
esac