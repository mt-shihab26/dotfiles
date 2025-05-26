#!/bin/env bash

set -e

echo -e "Updating package lists..."
sudo nala update

echo -e "\nInstalling Alacritty and wl-clipboard..."
sudo nala install -y alacritty wl-clipboard

echo -e "\nInstallation complete."
