#!/bin/bash

sudo pacman -S htop stow cloc tree wget gedit

# Set gedit as default application for markdown files
xdg-mime default gedit.desktop text/markdown
xdg-mime default gedit.desktop text/x-markdown
