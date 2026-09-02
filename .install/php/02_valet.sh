#!/bin/bash

set -e

echo "Installing Dependencies..."
# sudo pacman -S nss jq xsel networkmanager
sudo pacman -S xsel

# Requires PHP extensions: pcntl, posix, fileinfo, json
# These are compiled into Arch's php package by default (no extension= line needed) -
# confirm with `php -m`, they won't appear in php.ini or conf.d.

echo "Installing Valet Linux globally..."
# -W lets composer downgrade symfony/process (locked by laravel/installer)
# to the older version valet-linux requires.
composer global require cpriego/valet-linux -W

echo "Running Valet installation..."
valet install
