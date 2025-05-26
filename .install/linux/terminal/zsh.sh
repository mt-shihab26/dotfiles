#!/bin/env bash

set -e

echo -e "Updating package lists..."
sudo nala update

echo -e "\nInstalling CLI tools and utilities..."
sudo nala install zsh golang zoxide ripgrep bat eza plocate apache2-utils fd-find tldr -y

echo -e "\nInstalling latest fzf via Go..."
go install github.com/junegunn/fzf@latest

echo -e "\nChanging default shell to Zsh..."
chsh -s "$(which zsh)"

echo -e "\nInstallation complete. Please restart your terminal or log out and back in to start using Zsh."
