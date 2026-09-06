#!/bin/bash

set -e

echo "Installing Dependencies..."
sudo pacman -S xsel # nss jq networkmanager

echo "Installing Valet Linux globally..."
composer global require cpriego/valet-linux

echo "Running Valet installation..."
valet install

echo "Valet Linux installed."
