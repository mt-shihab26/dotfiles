#!/bin/sh

sudo pacman -S gnome-keyring gnome-themes-extra xdg-desktop-portal-gtk

yay -S catppuccin-gtk-theme-mocha

gsettings set org.gnome.desktop.interface gtk-theme "catppuccin-mocha-rosewater-standard+default"
gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"
