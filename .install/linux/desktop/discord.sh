#!/bin/bash

command="discord"

if ! command -v "$command" &>/dev/null; then
    echo "Checking for '$command'... not found."
    echo "Downloading and installing '$command'..."

    # Download and install Discord
    cd /tmp
    wget -O discord.deb "https://discord.com/api/download?platform=linux&format=deb"
    echo "Installing Discord from 'discord.deb'..."
    sudo apt install -y ./discord.deb
    echo "Removing temporary installation file..."
    rm ./discord.deb
    cd -

    echo "'$command' has been successfully installed."
else
    echo "'$command' is already installed on this system."
fi
