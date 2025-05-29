#!/bin/sh

sudo pacman -S --needed git base-devel

cd /tmp
git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
makepkg -si
cd -
cd -
