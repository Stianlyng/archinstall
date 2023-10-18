import os
import subprocess

def run_command(command):
    subprocess.run(command, shell=True)

# Install yay
run_command("sudo pacman -S --needed git base-devel")
run_command("git clone https://aur.archlinux.org/yay.git")
run_command("cd yay && makepkg -si && cd ..")

# Update and install essentials
run_command("sudo pacman -Syu --noconfirm base-devel git ranger neovim ly fish alacritty pcmanfm xclip tldr bspwm sxhkd firefox")

# Enable ly display manager
run_command("sudo systemctl enable ly")

# Change default shell
run_command("sudo chsh -s /bin/fish")

# Install dwm
run_command("sudo mkdir -p /usr/share/xsessions")

dwm_desktop_content = '''[Desktop Entry]
Encoding=UTF-8
Name=dwm
Comment=Dynamic window manager
Exec=dwm
Icon=dwm
Type=XSession
'''

with open("/usr/share/xsessions/dwm.desktop", "w") as f:
    f.write(dwm_desktop_content)

run_command("cd dwm && sudo make clean install")

print("End of script!")
