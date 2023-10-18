#!/bin/bash

# Install yay
sudo pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

# Update and install essentials
sudo pacman -Syu --noconfirm base-devel git ranger neovim ly fish alacritty pcmanfm xclip tldr bspwm sxhkd firefox

# Enable ly display manager
sudo systemctl enable ly

# Change default shell
sudo chsh -s /bin/fish

# Install dwm
sudo mkdir -p /usr/share/xsessions

cat <<EOL >> /usr/share/xsessions/dwm.desktop
[Desktop Entry]
Encoding=UTF-8
Name=dwm
Comment=Dynamic window manager
Exec=dwm
Icon=dwm
Type=XSession
EOL

cd dwm
sudo make clean install

echo 'End of script!'
