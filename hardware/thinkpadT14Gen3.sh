#!/bin/bash

####################
#	UTILS      #		
####################

write_to_file() {
  echo "$1" > tempfile
  sudo mkdir -p "$2"
  sudo mv tempfile "$2/$3"
  chmod +x "$2/$3"
}

####################
#     SERVICES     #		
####################

str="[Unit]
Description=Suspend: rmmod ath11k_pci
Before=sleep.target

[Service]
Type=simple
ExecStart=/usr/bin/rmmod ath11k_pci

[Install]
WantedBy=sleep.target"

write_to_file "$str" "/etc/systemd/system" "ath11k-suspend.service"

str="[Unit]
Description=Resume: modprobe ath11k_pci
After=suspend.target

[Service]
Type=simple
ExecStart=/usr/bin/modprobe ath11k_pci

[Install]
WantedBy=suspend.target"

write_to_file "$str" "/etc/systemd/system" "ath11k-resume.service"

sudo systemctl enable ath11k-suspend.service
sudo systemctl enable ath11k-resume.service

####################
#	Modem	   #		
####################

sudo pacman -S --noconfirm modemmanager usb_modeswitch 
sudo systemctl enable ModemManager.service

#todo: add modem profile - https://wiki.archlinux.org/title/Mobile_broadband_modem#ModemManager

# The integrated modem is supported by default, but you need a custom FCC unlock script for ModemManager.
sudo ln -s /usr/share/ModemManager/fcc-unlock.available.d/2c7c /etc/ModemManager/fcc-unlock.d/2c7c:030a

# Add network manager profile (PIN code etc)

echo "Enter password for decrypting sim card profile:"
read -s decryption_key

filename=Telia.nmconnection
src_path=network/connections
dest_path=/etc/Network/Manager/system-connections

echo $decryption_key | gpg --batch --passphrase-fd 0 $src_path/$filename.gpg

sudo mkdir -p $dest_path

sudo cp $src_path/$filename $dest_path/$filename

sudo chmod 600 $dest_path/$filename

####################
#     Mute fix     #		
####################

str='ACTION=="add", SUBSYSTEM=="leds", KERNEL=="platform::micmute" ATTR{trigger}="audio-micmute"'

write_to_file "$str" "/etc/udev/rules.d" "micmute-led.rules"

####################
#       Audio      #		
####################

sudo pacman -S --noconfirm sof-firmware
