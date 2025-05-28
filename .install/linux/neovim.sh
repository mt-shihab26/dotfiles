#!/bin/sh

set -e

sudo pacman -Syu
sudo pacman -S neovim lazygit wl-clipboard lua luarocks ripgrep imagemagick

./nodejs.sh
