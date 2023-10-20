#!/bin/bash

# Set the source and target directories
src_directory="/home/stian/media/wallpapers"
target_directory="/home/stian/media/wallpapers/8K"

# Set the pixel threshold
pixel_threshold=6000

# Create the target directory if it doesn't exist
mkdir -p "$target_directory"

# Loop through all image files in the source directory
find "$src_directory" -type f \( -iname \*.jpg -o -iname \*.jpeg -o -iname \*.png -o -iname \*.gif -o -iname \*.bmp \) | while read image; do
    # Get the image dimensions
    dimensions=$(identify -format "%w %h" "$image")

    # Split the dimensions into width and height
    width=$(echo "$dimensions" | awk '{print $1}')
    height=$(echo "$dimensions" | awk '{print $2}')

    # Check if the width or height is greater than or equal to the pixel threshold
    if [ "$width" -ge "$pixel_threshold" ] || [ "$height" -ge "$pixel_threshold" ]; then
        # Move the image to the target directory
        mv "$image" "$target_directory"
    fi
done
