#!/bin/sh

sudo pacman -S bob lazygit wl-clipboard lua luarocks imagemagick nodejs npm pnpm ripgrep fd base-devel gcc clang

bob install stable
bob install nightly

bob use stable
# bob use nightly
