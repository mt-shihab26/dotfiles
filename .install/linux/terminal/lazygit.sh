#!/bin/env bash

set -e

command="lazygit"

if ! command -v "$command" &>/dev/null; then
    echo -e "\nThe command '$command' does not exist."

    echo -e "\nDownloading and installing lazygit..."
    cd /tmp
    LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
    curl -sLo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
    tar -xf lazygit.tar.gz lazygit
    sudo install lazygit /usr/local/bin
    rm lazygit.tar.gz lazygit
    cd ~
else
    echo -e "\nThe command '$command' already exists."
fi

echo -e "\nlazygit installation complete."
