#!/bin/bash

set -e

echo -e "Installing tmux..."
sudo pacman -Sy tmux

rm -rf ~/.tmux

echo -e "\nCloning tmux plugin manager (TPM)..."
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

echo -e "\nInstalling tmux plugins..."
~/.tmux/plugins/tpm/bin/install_plugins

echo -e "\nTmux installation and setup completed successfully!"
