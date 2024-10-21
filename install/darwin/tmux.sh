#!/usr/bin/env zsh

echo "installing tmux..."
brew install tmux

echo "cloning tmux plugin manager (tpm)..."
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

echo "installing tmux plugins..."
~/.tmux/plugins/tpm/bin/install_plugins

echo "tmux installation and setup completed successfully!"
