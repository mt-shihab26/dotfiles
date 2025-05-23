echo "installing tmux..."
sudo apt install tmux -y

echo "cloning tmux plugin manager (tpm)..."
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

echo "installing tmux plugins..."
~/.tmux/plugins/tpm/bin/install_plugins

echo "installing additional tools tmux..."
sudo apt install bash bc coreutils gawk gh glab jq -y

echo "tmux installation and setup completed successfully!"
