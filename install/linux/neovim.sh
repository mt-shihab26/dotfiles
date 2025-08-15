#!/bin/sh

sudo pacman -Rns neovim

sudo pacman -S vim bob lazygit wl-clipboard lua luarocks imagemagick nodejs npm pnpm ripgrep fd base-devel gcc clang unzip

bob install stable
bob install nightly

# bob use stable
bob use nightly
