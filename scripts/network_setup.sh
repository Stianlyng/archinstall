#!/bin/bash

# Prompt the user for input
echo "Enter password for decrypting secrets:"
read -s decryption_key

file_path="network/connections"

# Check if directory exists
if [ ! -d "$file_path" ]; then
  echo "Directory $file_path does not exist."
  exit 1
fi

# Loop through all files in the directory
for file in "$file_path"/*; do
  echo "Processing $file"
  
  # Decrypt the file
  echo "$decryption_key" | gpg --batch --passphrase-fd 0 "$file" || {
    echo "Decryption failed for $file"
    exit 1
  }
done

# Copy ssh keys
sudo mkdir -p /etc/NetworkManager/system-connections
sudo cp -r "$file_path"/* /etc/NetworkManager/system-connections/ || {
  echo "Failed to copy files."
  exit 1
}

echo 'End of script!'
