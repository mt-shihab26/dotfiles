#!/bin/env bash

set -e

command="google-chrome"

if ! command -v "$command" &>/dev/null; then
    echo -e "The command '$command' does not exist."
    echo -e "Installing '$command' browser..."

    cd /tmp

    echo -e "\nDownloading Google Chrome .deb package..."
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb

    echo -e "\nInstalling Google Chrome..."
    sudo nala install -y ./google-chrome-stable_current_amd64.deb

    echo -e "\nCleaning up installer..."
    rm google-chrome-stable_current_amd64.deb
    cd -

    echo -e "\nGoogle Chrome installation completed successfully."
else
    echo -e "The command '$command' is already available on this system."
fi
