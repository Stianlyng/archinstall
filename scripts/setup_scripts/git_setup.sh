#!/bin/bash

# Start the ssh-agent
eval $(ssh-agent)

# Prompt the user for input
echo "Enter password for decrypting secrets:"
read -s decryption_key

# Decrypt the files
echo $decryption_key | gpg --batch --passphrase-fd 0 ssh/id_rsa.gpg
echo $decryption_key | gpg --batch --passphrase-fd 0 ssh/id_rsa.pub.gpg

# Copy ssh keys
mkdir -p $HOME/.ssh
echo pwd
cp -r ssh/* $HOME/.ssh/

# Set permissions
chmod 700 $HOME/.ssh
chmod 600 $HOME/.ssh/id_rsa
chmod 644 $HOME/.ssh/id_rsa.pub

# Add ssh keys to the agent
ssh-add $HOME/.ssh/id_rsa

# Change from the https to ssh origin in the repo
git remote set-url origin git@github.com:Stianlyng/conf.git

# add git username
git config --global user.email "stianlyng@protonmail.com"
git config --global user.name "Stian Lyng"
