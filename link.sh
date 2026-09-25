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

# Keep applications a real dir so stow only links our .desktop files into it.
create_tmp ".local/share/applications"

cd "$HOME/dotfiles"

omarchy pkg add stow

stow .

hyprctl reload
