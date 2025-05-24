#!/bin/env bash

set -e

echo -e "Creating font directory..."
mkdir -p ~/.local/share/fonts

cd /tmp

echo -e "\nDownloading CascadiaMono Nerd Font..."
wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/CascadiaMono.zip
unzip CascadiaMono.zip -d CascadiaFont
cp CascadiaFont/*.ttf ~/.local/share/fonts
rm -rf CascadiaMono.zip CascadiaFont

echo -e "\nRebuilding font cache..."
fc-cache

cd -

echo -e "Fonts installed successfully!"
