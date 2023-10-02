#!/bin/bash

ask_yes_no() {
    local prompt="$1"
    local response

    read -p "$prompt [Y/n] " response

    # If Enter is pressed, set response to 'Y'
    : ${response:='Y'}

    case "$response" in
        [yY][eE][sS]|[yY]|'')
            return 0 ;;
        [nN][oO]|[nN])
            return 1 ;;
        *)
            echo "Invalid response."
            return 2 ;;
    esac
}

# Update and install essentials
sudo pacman -Syu 
sudo pacman -S --noconfirm base-devel git ranger neovim terminus-font zsh

# add dotfiles 
cp archinstall/.config/nvim ~/.config/nvim
cp .zshrc ~/.zshrc

# Change default shell
chsh -s /bin/zsh
if ask_yes_no "Do you want to install starship for zsh?"; then
    sudo pacman -S --noconfirm starship
    # Append the starship init command to the .zshrc file
    echo 'eval "$(starship init zsh)"' >> ~/.zshrc
fi

# Clone dotfiles and configs
git clone https://github.com/Stianlyng/archinstall.git

if ask_yes_no "Do you want to use dwm window manager?"; then
    echo "You chose yes."

    # Install dwm dependencies and other software
    sudo pacman -S --noconfirm xorg-server xorg-xinit libx11 libxft libxinerama alacritty

    # Install dwm
    cd archinstall/dwm
    sudo make clean install
    echo 'Successfully installed dwm'
    cd ~/
    cp archinstall/xinitrc_dwm ~/.xinitrc
fi

if ask_yes_no "The installer is finished, do you want to log out for the canges to make effect?"; then
    exit
fi
