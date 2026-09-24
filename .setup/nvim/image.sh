#!/bin/bash

set -e

# Dependencies for snacks.nvim image (.config/nvim/lua/plugins/snacks.lua)
# kitty renders the images, imagemagick converts formats, ghostscript renders pdf,
# tectonic renders latex math
sudo pacman -S --needed --noconfirm kitty imagemagick ghostscript tectonic

# mermaid-cli (mmdc) renders mermaid diagrams
if ! command -v mmdc >/dev/null 2>&1; then
  bun install -g @mermaid-js/mermaid-cli
fi
