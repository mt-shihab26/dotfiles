#!/bin/bash

set -e

echo -e "\nAdding Fastfetch PPA..."
sudo add-apt-repository -y ppa:zhangsongcui3371/fastfetch

echo -e "\nUpdating package lists..."
sudo apt update -y

echo -e "\nInstalling Fastfetch..."
sudo apt install -y fastfetch

echo -e "\nFastfetch installation complete.\n"
