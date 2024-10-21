#!/usr/bin/env zsh

echo "installing tmux..."
brew install tmux

echo "cloning tmux plugin manager (tpm)..."
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

echo "installing tmux plugins..."
~/.tmux/plugins/tpm/bin/install_plugins

echo "installing fonts for tokyo-night tmux..."
brew install --cask font-monaspace-nerd-font font-noto-sans-symbols-2

echo "installing additional tools for tokyo-night tmux..."
brew install bash bc coreutils gawk gh glab gsed jq nowplaying-cli

echo "tmux installation and setup completed successfully!"

