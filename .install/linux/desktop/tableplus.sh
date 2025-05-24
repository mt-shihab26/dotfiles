#!/bin/env bash

set -e

echo -e "Adding TablePlus GPG key..."
wget -qO - https://deb.tableplus.com/apt.tableplus.com.gpg.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/tableplus-archive.gpg >/dev/null

echo -e "\nAdding TablePlus APT repository..."
sudo add-apt-repository -y "deb [arch=amd64] https://deb.tableplus.com/debian/24 tableplus main"

echo -e "\nUpdating package lists..."
sudo apt update -y

echo -e "\nInstalling TablePlus..."
sudo apt install -y tableplus

echo -e "\nTablePlus installation complete."
