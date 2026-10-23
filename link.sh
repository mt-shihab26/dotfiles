#!/usr/bin/env bash

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
create_tmp ".claude"
create_tmp ".config/opencode"
create_tmp ".local/share/applications"

cd "$HOME/dotfiles"

omarchy pkg add stow

stow .

hyprctl reload
