#!/bin/bash

# Get the output of 'hyprctl activewindow'
output=$(hyprctl activewindow)

# Extract the 'class' field
window_class=$(echo "$output" | grep "class:" | awk '{print $2}')

# Check if the class is 'Alacritty'
if [[ $window_class == "Alacritty" ]]; then
	# Extract the 'title' field
	window_title=$(echo "$output" | grep "title:" | awk -F "title: " '{print $2}')

	# Extract the path from the title
	path=$(echo "$window_title" | awk -F ":" '{print $2}' | sed 's/~//')

	# Open a new instance of Alacritty with the extracted path as the working directory
	alacritty --working-directory "$HOME/$path" &
fi
