#!/bin/bash

set -e

sudo pacman -S --noconfirm htop stow cloc tree wget

yay -S --noconfirm todoist-appimage
yay -S --noconfirm tableplus
