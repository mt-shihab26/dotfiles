#!/bin/env bash

set -e

echo -e "Adding Fastfetch PPA..."
sudo add-apt-repository -y ppa:zhangsongcui3371/fastfetch

echo -e "\nUpdating package lists..."
sudo nala update

echo -e "\nInstalling Fastfetch..."
sudo nala install -y fastfetch

echo -e "\nFastfetch installation complete.\n"
