#!/bin/env bash

set -e

echo -e "Changing to /tmp directory..."
cd /tmp

echo -e "\nDownloading and installing NVM..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash

echo -e "\nLoading NVM without restarting the shell..."
. "$HOME/.nvm/nvm.sh"

echo -e "\nInstalling Node.js v22..."
nvm install 22

echo -e "\nVerifying Node.js installation..."
node -v
nvm current

echo -e "\nVerifying npm version..."
npm -v

echo -e "\nInstalling pnpm..."
npm install -g pnpm@latest
pnpm -v

echo -e "\nReturning to previous directory..."
cd -

echo -e "\nNode.js, NVM, and PNPM installation complete."
