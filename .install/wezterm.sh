#!/usr/bin/env bash
set -e

# Install WezTerm nightly from AUR (better Wayland/Hyprland compatibility
# and improved HarfBuzz complex script shaping for Bengali and other Indic scripts)
#
# NOTE: If wezterm-nightly-bin fails to install or has launch issues on Hyprland,
# try these steps:
#   1. Check your distro: this script targets Arch Linux
#   2. Check your WezTerm version: yay -Qi wezterm-nightly-bin
#   3. For Wayland launch issues, set enable_wayland = false in ~/.config/wezterm/wezterm.lua
#      or try: WAYLAND_DISPLAY= wezterm start --always-new-process
#
# Uninstall the stable version first if installed
if pacman -Qq wezterm &>/dev/null; then
    sudo pacman -Rns --noconfirm wezterm
fi

yay -S --noconfirm wezterm-nightly-bin

# # Set WezTerm as the default terminal via xdg-terminal-exec
# TERMINALS_LIST="${XDG_CONFIG_HOME:-$HOME/.config}/xdg-terminals.list"
# if ! grep -q "wezterm.desktop" "$TERMINALS_LIST" 2>/dev/null; then
#   sed -i '1s/^/wezterm.desktop\n/' "$TERMINALS_LIST"
# fi
