#!/bin/bash

set -e

# undo: omarchy plugin disable mt-shihab26.background && omarchy plugin enable omarchy.background
#

# Swap Omarchy's background plugin for my clone (.config/omarchy/plugins/mt-shihab26.background),
# which fits the whole wallpaper on screen (like CSS object-fit: contain) instead of cropping it.
# Run ./link.sh first so the clone is linked into ~/.config/omarchy/plugins.

omarchy-shell shell rescanPlugins

omarchy plugin enable mt-shihab26.background
