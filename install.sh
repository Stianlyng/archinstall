#!/bin/bash

config_dir="$HOME/.config"

# Default apps
term=alacritty
browser=firefox
cli_filemanager=ranger
gui_filemanager=nemo
launcher=rofi
shell=zsh
display_manager=ly

sudo echo "Script started"

##################################################
##						##
##		     home			##
##						##
##################################################
mkdir -p $HOME/code
mkdir -p $HOME/.local/share/

##################################################
##						##
##		     dotfiles			##
##						##
##################################################

chmod -R 755 configs
chmod -R 755 scripts
chmod -R 755 hardware

#############	    Symlinks 	      ############

# regular
ln -fs $(pwd)/configs/$term      $config_dir/$term
ln -fs $(pwd)/configs/kmonad     $config_dir/kmonad
ln -fs $(pwd)/configs/nvim       $config_dir/nvim

# X11 (bspwm)
ln -fs $(pwd)/configs/bspwm      $config_dir/bspwm
ln -fs $(pwd)/configs/rofi 	 $config_dir/rofi
ln -fs $(pwd)/configs/sxhkd	 $config_dir/sxhkd

# Wayland (hypr)
ln -fs $(pwd)/configs/hypr	 $config_dir/hypr
ln -fs $(pwd)/configs/waybar	 $config_dir/waybar

# Other 
ln -fs $(pwd)/wallpapers	 $HOME/.wallpapers
ln -fs $(pwd)/scripts		 $HOME/.scripts
ln -fs $(pwd)/fonts 		 $HOME/.local/share/fonts
ln -fs $(pwd)/desktopfiles 	 $HOME/.local/share/applications

# Shell environments
ln -fs $(pwd)/configs/zshrc	 $HOME/.zshrc
ln -fs $(pwd)/configs/bashrc	 $HOME/.bashrc
ln -fs $(pwd)/configs/profile    $HOME/.profile

# refresh fonts cache
fc-cache -fv

##################################################
##						##
##		     Scrips			##
##						##
##################################################

packages=(

  # Essentials
  "$term"
  "$browser"
  "$cli_filemanager"
  "$gui_filemanager"
  "$launcher"
  "$display_manager"
  "$shell"
  "base-devel"
  "openssh"
  "git"
  "fzf"
  "neovim"
  "tldr"
  "polkit-kde-agent"
  "dunst"
  "dmidecode"
  "gnupg" # encryption for secrets etc..

  # Development
  "nodejs"
  "npm"

  # For X11
  "bspwm"
  "sxhkd"
  "xclip"
  "nitrogen"
  "polybar"
  "xorg"

  # For Wayland
  "hyprland"
  "xdg-desktop-portal-hyprland"
  "swaybg"
  "waybar"
)

for pkg in "${packages[@]}"; do
  sudo pacman -S --needed --noconfirm $pkg || echo "Failed to install $pkg" >> logfile.txt
done

# Install yay
git clone https://aur.archlinux.org/yay.git 
cd yay
makepkg -si
cd ..
rm -rf yay

# Enable ly display manager
sudo systemctl enable $display_manager

###########	SHELL	###########

# Change default shell
chsh -s /bin/$shell

###########	SSH	###########

./scripts/git_setup.sh

###########	HARDWARE	###########

# Change modkey if running inside a VM

if sudo dmidecode -s system-manufacturer | grep -iq "vmware\|virtualbox\|xen\|kvm\|qemu\|Microsoft Corporation"; then
  echo "Running in a VM"

  # Set custom modkey
  ./scripts/utils/replace_words.sh configs/sxhkd/sxhkdrc super alt
  ./scripts/utils/replace_words.sh configs/hypr/keybinds.conf SUPER alt

else
  echo "Not running in a VM"
fi

# Choose spesific machine configs

PS3="Select a file: "

files=$(ls hardware)

select file in Default $files
do
    case $file in
        "Quit")
            echo "Exiting."
            break;;
        *)
            if [[ -n $file ]]; then
                echo "You selected $file"
		./hardware/$file
                break
            else
                echo "Invalid selection"
            fi
            ;;
    esac
done


echo 'End of script!'
