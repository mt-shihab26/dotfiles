#!/usr/bin/env bash

set -e

cd "$HOME/dotfiles"

stow -D .

hyprctl reload
