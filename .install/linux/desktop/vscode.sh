#!/bin/env bash

set -e

echo -e "Adding Microsoft GPG key..."
cd /tmp
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor >packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg

echo -e "\nAdding VS Code repository..."
echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" |
    sudo tee /etc/apt/sources.list.d/vscode.list >/dev/null

echo -e "\nCleaning up temporary files..."
rm -f packages.microsoft.gpg
cd -

echo -e "\nUpdating package list..."
sudo nala update

echo -e "\nInstalling Visual Studio Code..."
sudo nala install -y code

echo -e "\nInstalling VS Code extensions..."
code --install-extension enkia.tokyo-night
code --install-extension auiworks.amvim

echo -e "Visual Studio Code installation and configuration complete!"
