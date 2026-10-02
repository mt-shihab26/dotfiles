#!/bin/bash

set -e

# Dependencies for snacks.nvim image (.config/nvim/lua/plugins/snacks.lua)
# kitty renders the images, imagemagick converts formats, ghostscript renders pdf,
# tectonic renders latex math
# kitty: https://github.com/kovidgoyal/kitty https://archlinux.org/packages/extra/x86_64/kitty/
# imagemagick: https://www.imagemagick.org/ https://archlinux.org/packages/extra/x86_64/imagemagick/
# ghostscript: https://www.ghostscript.com/ https://archlinux.org/packages/extra/x86_64/ghostscript/
# tectonic: https://tectonic-typesetting.github.io/ https://archlinux.org/packages/extra/x86_64/tectonic/
omarchy pkg add kitty imagemagick ghostscript tectonic

# mermaid-cli (mmdc) renders mermaid diagrams
if ! command -v mmdc >/dev/null 2>&1; then
    bun install -g @mermaid-js/mermaid-cli
fi
