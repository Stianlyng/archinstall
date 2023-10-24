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
ln -fs $(pwd)/configs/$term      $config_dir/$term
ln -fs $(pwd)/configs/kmonad     $config_dir/kmonad
ln -fs $(pwd)/configs/nvim       $config_dir/nvim


# Other 
ln -fs $(pwd)/wallpapers	 $HOME/.wallpapers
ln -fs $(pwd)/scripts		 $HOME/.scripts
ln -fs $(pwd)/fonts 		 $HOME/.local/share/fonts
ln -fs $(pwd)/desktopfiles 	 $HOME/.local/share/applications

# Shell environments
ln -fs $(pwd)/configs/zshrc	 $HOME/.zshrc
ln -fs $(pwd)/configs/bashrc	 $HOME/.bashrc
ln -fs $(pwd)/configs/profile    $HOME/.profile


##################################################
##						##
##		     Scrips			##
##						##
##################################################

packages=(

  # Essentials
  "$term"
  "$cli_filemanager"
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

if ask_question "Do you want to install a graphical environment (Hyprland)"; then

  packages+=( 
  "$browser"
  "$launcher"
  "$gui_filemanager"
  "polkit-kde-agent"

  # Hyprland
  "hyprland"
  "xdg-desktop-portal-hyprland"
  "swaybg"
  "waybar"
  "dunst"
  )

  ln -s $(pwd)/configs/rofi 	  $config_dir/rofi
  ln -s $(pwd)/configs/rofi 	  $config_dir/rofi
  ln -s $(pwd)/configs/hypr	 $config_dir/hypr
  ln -s $(pwd)/configs/waybar	 $config_dir/waybar
  ln -s $(pwd)/configs/cheatsheet.md $config_dir/cheatsheet.md # hypr keybinds
else
  echo "You chose not to install graphical apps."
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

#######################################################


# refresh fonts cache. uncomment if fonts is not added correctly
#fc-cache -fv
echo 'End of script!'
