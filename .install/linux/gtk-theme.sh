#!/bin/sh

sudo pacman -S gnome-themes-extra xdg-desktop-portal-gtk # Adds Adwaita-dark theme
gsettings set org.gnome.desktop.interface gtk-theme "Adwaita-dark"
gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"
