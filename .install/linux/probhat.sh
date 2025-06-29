#!/bin/sh

sudo pacman -S xkeyboard-config
localectl list-x11-keymap-layouts | grep bd
localectl list-x11-keymap-variants bd
setxkbmap -layout bd -variant probhat
