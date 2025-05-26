#!/bin/env bash

set -e

command="discord"

if ! command -v "$command" &>/dev/null; then
    echo -e "Checking for '$command'... not found."
    echo -e "Downloading and installing '$command'..."

    cd /tmp

    echo -e "\nDownloading Discord .deb package..."
    wget -O discord.deb "https://discord.com/api/download?platform=linux&format=deb"

    echo -e "\nInstalling Discord..."
    sudo nala install -y ./discord.deb

    echo -e "\nCleaning up..."
    rm ./discord.deb
    cd -

    echo -e "\n'$command' has been successfully installed."
else
    echo -e "'$command' is already installed on this system."
fi
