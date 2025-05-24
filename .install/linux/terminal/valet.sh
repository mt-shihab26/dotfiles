#!/bin/bash

echo -e "\nRunning PHP installation script..."
bash ./php.sh

echo -e "\nRemoving Apache2 if installed..."
sudo apt remove -y apache2

echo -e "\nUpdating package lists..."
sudo apt update

echo -e "\nInstalling required system packages for Valet Linux..."
sudo apt install -y network-manager libnss3-tools jq xsel nginx

echo -e "\nInstalling Valet Linux globally via Composer..."
composer global require cpriego/valet-linux

echo -e "\nInstalling Valet..."
valet install

echo -e "\nValet installation complete."
