#!/bin/bash

set -e

sudo pacman -S --noconfirm zsh fzf zoxide

chsh -s "$(which zsh)"

echo -e "\nInstallation complete. Please restart your terminal or log out and back in to start using Zsh."
