#!/usr/bin/env zsh

set -e

if [ ! -d "$HOME/.ssh" ]; then
    mkdir -p "$HOME/.ssh"
fi
touch "$HOME/.ssh/.keep"

cd "$HOME/dotfiles"

stow .

hyprctl reload
