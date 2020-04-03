#!/bin/bash

echo ""
read -p "Would you like to configure an ssh key for GitHub? [Y/n]: " response
response=${response:-y}
if [ "$response" = "y" ]; then
  echo ""
  echo -n "Please enter your GitHub email: "
  read response
  ssh-keygen -t rsa -b 4096 -C "$response"
    cat > ~/.ssh/config <<-EOF
Host *
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ~/.ssh/id_rsa
EOF
  eval "$(ssh-agent -s)"
  ssh-add -K ~/.ssh/id_rsa

  read -p "Would you like to copy the public key file to enter on GitHub? [Y/n]: " response
  response=${response:-y}
  if [ "$response" = "y" ]; then
    echo ""
    read -p "Please enter the name of the id_rsa.pub file: [id_rsa.pub] " response
    response=${response:-id_rsa.pub}
    pbcopy < "$HOME/.ssh/$response"
  fi
fi
