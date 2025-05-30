#!/bin/sh

sudo pacman -S uwsm libnewt pipewire wireplumber hyprland waybar libnotify swaync hyprlock hypridle wpaperd iwd brightnessctl

# Screenshot

yay -S hyprshot

# Network Manager
yay -S iwgtk

sudo systemctl enable iwd
sudo systemctl start iwd

# Bluetooth Manager

yay -S overskride-bin

sudo systemctl enable bluetooth
sudo systemctl start bluetooth
