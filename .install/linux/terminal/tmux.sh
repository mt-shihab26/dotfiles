#!/bin/env bash

set -e

echo -e "Installing tmux..."
sudo apt install -y tmux

echo -e "\nCloning tmux plugin manager (TPM)..."
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

echo -e "\nInstalling tmux plugins..."
~/.tmux/plugins/tpm/bin/install_plugins

echo -e "\nInstalling additional tools used with tmux..."
sudo apt install -y bash bc coreutils gawk gh glab jq

echo -e "\nTmux installation and setup completed successfully!"
