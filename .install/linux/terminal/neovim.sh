#!/bin/env bash

set -e

command="nvim"

echo -e "Checking for '$command'..."

if ! command -v "$command" &>/dev/null; then
    echo -e "[WARN] The command '$command' does not exist."
    echo -e "[INFO] Installing '$command'..."

    cd /tmp
    wget -O nvim.tar.gz "https://github.com/neovim/neovim/releases/download/stable/nvim-linux-x86_64.tar.gz"
    tar -xf nvim.tar.gz
    sudo install nvim-linux-x86_64/bin/nvim /usr/local/bin/nvim
    sudo cp -R nvim-linux-x86_64/lib /usr/local/
    sudo cp -R nvim-linux-x86_64/share /usr/local/
    rm -rf nvim-linux-x86_64 nvim.tar.gz
    cd -
    hash -r

    echo -e "Neovim installed successfully."
else
    echo -e "The command '$command' already exists."
fi

echo -e "\nInstalling required dependencies..."
sudo nala update
sudo nala install -y wget tar luarocks tree-sitter-cli python3.12-venv

echo -e "\nRunning LazyGit setup..."
bash ./lazygit.sh

echo -e "\nRunning PHP setup..."
bash ./php.sh
bash ./composer.sh

echo -e "\nRunning Nodejs setup..."
bash ./nodejs.sh

echo -e "\nAll tools installed and configured.\n"
