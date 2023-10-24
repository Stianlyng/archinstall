#!/bin/bash

username='stian'
# Install kmonad (AUR)
echo 'installing kmonad'
yay -S kmonad-bin

# Step 1: Make sure the uinput group exists
echo "Creating uinput group if it doesn't exist..."
sudo groupadd -f uinput

# Step 2: Add your user to the input and uinput groups

echo "Adding $username to input and uinput groups..."
sudo usermod -aG input $username
sudo usermod -aG uinput $username

# Step 3: Verify that the changes are effective
echo "You might have to logout and login for the changes to take effect."
echo "You can run the 'groups' command to verify that $username is part of the input and uinput groups."

# Step 4: Add udev rule for uinput
echo "Adding udev rule for uinput..."
echo 'KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"' | sudo tee /etc/udev/rules.d/99-uinput.rules > /dev/null

# Reload udev rules
sudo udevadm control --reload-rules && sudo udevadm trigger

# Step 5: Make sure uinput drivers are loaded
echo "Loading uinput module..."
sudo modprobe uinput

echo "All done! You may now proceed to use KMonad."
