#!/bin/bash

set -e

# Dependencies for snacks.nvim image (.config/nvim/lua/plugins/snacks.lua)
# kitty renders the images, imagemagick converts formats, ghostscript renders pdf,
# tectonic renders latex math
for pkg in kitty imagemagick ghostscript tectonic; do
    if ! pacman -Q "$pkg" >/dev/null 2>&1; then
        sudo pacman -S --noconfirm "$pkg"
    fi
done

# mermaid-cli (mmdc) renders mermaid diagrams
if ! command -v mmdc >/dev/null 2>&1; then
    bun install -g @mermaid-js/mermaid-cli
fi
