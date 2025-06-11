#!/bin/sh

sudo pacman -S bluez

sudo systemctl enable bluetooth
sudo systemctl start bluetooth
