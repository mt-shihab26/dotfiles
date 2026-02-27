#!/bin/bash

echo "Installing Dependencies..."
sudo pacman -S nss jq xsel networkmanager

echo "Installing Valet Linux globally..."
composer global require cpriego/valet-linux

echo "Running Valet installation..."
valet install
