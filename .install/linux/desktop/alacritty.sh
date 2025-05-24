#!/bin/env bash

set -e

echo -e "Updating package lists..."
sudo apt update

echo -e "\nInstalling Alacritty and wl-clipboard..."
sudo apt install -y alacritty wl-clipboard

echo -e "\nInstallation complete."
