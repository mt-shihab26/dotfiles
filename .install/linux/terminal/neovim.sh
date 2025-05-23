#!/bin/bash
set -e

command_to_check="nvim"

if ! command -v "$command_to_check" &>/dev/null; then
    echo "The command '$command_to_check' does not exist."
    echo "Installing '$command_to_check'"
    cd /tmp
    wget -O nvim.tar.gz "https://github.com/neovim/neovim/releases/download/stable/nvim-linux-x86_64.tar.gz"
    tar -xf nvim.tar.gz
    sudo install nvim-linux-x86_64/bin/nvim /usr/local/bin/nvim
    sudo cp -R nvim-linux-x86_64/lib /usr/local/
    sudo cp -R nvim-linux-x86_64/share /usr/local/
    rm -rf nvim-linux-x86_64 nvim.tar.gz
    cd -
    hash -r
else
    echo "The command '$command_to_check' exists."
fi

# Install dependencies
sudo apt update
sudo apt install -y wget tar luarocks tree-sitter-cli python3.12-venv

# Continue with PHP setup
bash ./php.sh
