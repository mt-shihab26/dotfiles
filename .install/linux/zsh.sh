#!/bin/sh

set -e

echo -e "Updating package lists..."
sudo pacman -Syu

echo -e "\nInstalling CLI tools and utilities..."
sudo pacman -S zsh fzf zoxide

echo -e "\nChanging default shell to Zsh..."
chsh -s "$(which zsh)"

echo -e "\nInstallation complete. Please restart your terminal or log out and back in to start using Zsh."

