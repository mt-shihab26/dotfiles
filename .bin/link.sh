#!/usr/bin/env zsh

set -e

create_tmp() {
    if [ -z "$1" ]; then
        echo "Usage: create_keep <directory>"
        return 1
    fi
    mkdir -p "$HOME/$1"
    touch "$HOME/$1/.tmp"
}

create_keep ".ssh"
create_keep ".local/bin"

cd "$HOME/dotfiles"

stow .

hyprctl reload
