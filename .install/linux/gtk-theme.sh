#!/bin/sh

sudo pacman -S nwg-look

git clone https://github.com/Fausto-Korpsvart/Tokyonight-GTK-Theme.git /tmp/Tokyonight-GTK-Theme
bash /tmp/Tokyonight-GTK-Theme/themes/install.sh
sudo mv ~/.themes/* /usr/share/themes/
