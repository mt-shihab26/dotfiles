#!/bin/sh

sudo pacman -S waybar

# Logout Manager
yay -S wlogout wayland-logout

# Network Manager
sudo pacman -S iwd
yay -S iwgtk

sudo systemctl enable iwd
sudo systemctl start iwd

# Bluetooth Manager
sudo pacman -S bluez bluez-utils blueman

sudo systemctl enable bluetooth
sudo systemctl start bluetooth

# Volume Control
sudo pacman -S pipewire wireplumber pavucontrol pamixer

# Birghtness Control
sudo pacman -S brightnessctl gammastep
