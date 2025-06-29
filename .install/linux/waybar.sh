#!/bin/sh

sudo pacman -S waybar

# Birghtness Control
sudo pacman -S brightnessctl gammastep

# Logout Manager
yay -S wlogout wayland-logout

# Bluetooth
# sudo pacman -S blueberry
sudo systemctl enable --now bluetooth

# Power profile
sudo pacman -S power-profiles-daemon
