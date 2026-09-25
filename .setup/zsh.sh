#!/bin/bash

set -e

omarchy pkg add zsh fzf zoxide

chsh -s "$(which zsh)"

echo -e "\nInstallation complete. Please restart your terminal or log out and back in to start using Zsh."
