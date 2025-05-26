#!/bin/env bash

set -e

echo -e "Running PHP installation script..."
bash ./php.sh

echo -e "\nRemoving Apache2 if installed..."
sudo nala remove -y apache2

echo -e "\nUpdating package lists..."
sudo nala update

echo -e "\nInstalling required system packages for Valet Linux..."
sudo nala install -y network-manager libnss3-tools jq xsel nginx dnsmasq inotify-tools

echo -e "\nInstalling Valet Linux globally via Composer..."
composer global require cpriego/valet-linux

echo -e "\nInstalling Valet..."
valet install

echo -e "\nValet installation complete."
