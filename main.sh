#!/bin/bash

# Install yay
pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

# Update and install essentials
pacman -Syu --noconfirm base-devel git ranger neovim ly fish alacritty pcmanfm tldr bspwm sxhkd 

# Enable ly display manager
systemctl enable ly

# Change default shell
chsh -s /bin/fish

# CONFIG FILES


# BSPWM

mkdir -p ~/.config/bspwm
cat <<EOL >> ~/.config/bspwm/bspwmrc
#! /bin/sh

pgrep -x sxhkd > /dev/null || sxhkd &

bspc monitor DP-0 -d 1 2 3 4 5 
bspc monitor HDMI-0 -d 6 7 8 9

bspc config border_width         4
bspc config window_gap          12
bspc config top_padding 	30

bspc config split_ratio          0.52
bspc config borderless_monocle   true
bspc config gapless_monocle      true
bspc config pointer_follows_focus true
bspc config focus_follows_pointer true

# BORDER

bspc config focused_border_color	"#8be9fd"
bspc config normal_border_color		"#282a36"
bspc config active_border_color		"#ff79c6"
EOL

echo 'End of script!'
