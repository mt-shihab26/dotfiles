#!/bin/bash

set -e

create_tmp() {
    if [ -z "$1" ]; then
        echo "Usage: create_keep <directory>"
        return 1
    fi
    mkdir -p "$HOME/$1"
    touch "$HOME/$1/.tmp"
}

create_tmp ".local/bin"

create_tmp ".config/claude"
create_tmp ".config/claude/personal"
create_tmp ".config/claude/professional"

create_tmp ".config/opencode"

cd "$HOME/dotfiles"

if ! command -v stow &>/dev/null; then
    sudo pacman -S stow
fi

stow .

hyprctl reload
