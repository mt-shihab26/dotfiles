#!/bin/env bash

set -e

echo -e "Creating font directory..."
mkdir -p ~/.local/share/fonts

cd /tmp

echo -e "\nDownloading iA Writer Mono fonts..."
wget -O iafonts.zip https://github.com/iaolo/iA-Fonts/archive/refs/heads/master.zip
unzip iafonts.zip -d iaFonts
cp iaFonts/iA-Fonts-master/iA\ Writer\ Mono/Static/iAWriterMonoS-*.ttf ~/.local/share/fonts
rm -rf iafonts.zip iaFonts

echo -e "\nRebuilding font cache..."
fc-cache

cd -

echo -e "Fonts installed successfully!"
