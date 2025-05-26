#!/bin/env bash

set -e

command="obsidian"

if ! command -v "$command" &>/dev/null; then
    echo -e "Checking for '$command'... not found."
    echo -e "Downloading and installing '$command'..."

    cd /tmp

    echo -e "\nDownloading Obsidian .deb package..."
    wget -O obsidian.deb "https://github.com/obsidianmd/obsidian-releases/releases/download/v1.8.10/obsidian_1.8.10_amd64.deb"

    echo -e "\nInstalling Obsidian..."
    sudo nala install -y ./obsidian.deb

    echo -e "\nCleaning up..."
    rm ./obsidian.deb
    cd -

    echo -e "\n'$command' has been successfully installed."
else
    echo -e "'$command' is already installed on this system."
fi
