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


##################################################
##						##
##		     methods			##
##						##
##################################################

ask_question() {
  local prompt="$1"
  local default_answer="Y"

  read -p "${prompt} [Y/n] " answer

  if [[ -z "$answer" ]]; then
    answer="$default_answer"
  fi

  [[ "$answer" =~ ^[Yy]$ ]]
}

# Example usage
# if ask_question "Do you want to continue?"; then
#   echo "You chose to continue."
# else
#   echo "You chose not to continue."
# fi

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
ln -s $(pwd)/configs/$term      $config_dir/$term
ln -s $(pwd)/configs/kmonad     $config_dir/kmonad
ln -s $(pwd)/configs/nvim       $config_dir/nvim


# Other 
ln -s $(pwd)/wallpapers	 $HOME/.wallpapers
ln -s $(pwd)/scripts		 $HOME/.scripts
ln -s $(pwd)/fonts 		 $HOME/.local/share/fonts
ln -s $(pwd)/desktopfiles 	 $HOME/.local/share/applications

# Shell environments
ln -s $(pwd)/configs/zshrc	 $HOME/.zshrc
ln -s $(pwd)/configs/bashrc	 $HOME/.bashrc
ln -s $(pwd)/configs/profile    $HOME/.profile

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
  "$cli_filemanager"
  "$launcher"
  "$display_manager"
  "$shell"
  "base-devel"
  "openssh"
  "git"
  "fzf"
  "neovim"
  "tldr"
  "dmidecode"
  "gnupg" # encryption for secrets etc..

  # Development
  "nodejs"
  "npm"

)

#########               Graphical  	    #########

if ask_question "Do you want to install graphical apps such as firefox and nemo?"; then

  packages += ( 
  "$browser"
  "$gui_filemanager"
  "polkit-kde-agent"
  "dunst"
  )

  ln -s $(pwd)/configs/bspwm      $config_dir/bspwm
  ln -s $(pwd)/configs/rofi 	  $config_dir/rofi
  ln -s $(pwd)/configs/sxhkd	  $config_dir/sxhkd

else
  echo "You chose not to install bspwm."
fi

#########               BSPWM               #########

if ask_question "Do you want to install bspwm?"; then

  packages += ( 
    "bspwm"
    "sxhkd"
    "xclip"
    "nitrogen"
    "polybar"
    "xorg"
  )

  ln -s $(pwd)/configs/bspwm      $config_dir/bspwm
  ln -s $(pwd)/configs/rofi 	  $config_dir/rofi
  ln -s $(pwd)/configs/sxhkd	  $config_dir/sxhkd

else
  echo "You chose not to install bspwm."
fi

#########               Hyprland              #########

if ask_question "Do you want to install hyprland?"; then

  packages += ( 
    "hyprland"
    "xdg-desktop-portal-hyprland"
    "swaybg"
    "waybar"
  )

  ln -s $(pwd)/configs/hypr	 $config_dir/hypr
  ln -s $(pwd)/configs/waybar	 $config_dir/waybar


else
  echo "You chose not to install hyprland."
fi


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

##################################################
##						##
##		     Hardware			##
##						##
##################################################

####   Change modkey if running inside a VM   ####
#
if sudo dmidecode -s system-manufacturer | grep -iq "vmware\|virtualbox\|xen\|kvm\|qemu\|Microsoft Corporation"; then
  echo "Running in a VM"

  # Set custom modkey
  ./scripts/utils/replace_words.sh configs/sxhkd/sxhkdrc super alt
  ./scripts/utils/replace_words.sh configs/hypr/keybinds.conf SUPER alt

else
  echo "Not running in a VM"
fi

####     Choose spesific machine configs     ####

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
