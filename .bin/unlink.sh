#!/usr/bin/env zsh

set -e

cd "$HOME/dotfiles"

stow -D .

hyprctl reload
