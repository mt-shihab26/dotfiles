#!/bin/sh

sudo pacman -S gnome-keyring gnome-themes-extra xdg-desktop-portal-gtk
gsettings set org.gnome.desktop.interface gtk-theme "Adwaita-dark"
gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"
