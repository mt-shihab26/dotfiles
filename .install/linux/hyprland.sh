#!/bin/sh

sudo pacman -S hyprland waybar libnotify swaync hyprlock hypridle wpaperd iwd brightnessctl mpd

# Network Manager
yay -S iwgtk

sudo systemctl enable iwd
sudo systemctl start iwd

# Bluetooth Manager

yay -S overskride-bin

sudo systemctl enable bluetooth
sudo systemctl start bluetooth

# Music Player Daemon
sudo systemctl enable mpd
sudo systemctl start mpd
