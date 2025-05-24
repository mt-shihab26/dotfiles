#!/bin/bash

set -e

echo -e "\nInstalling Git..."
sudo apt install git -y

echo -e "\nConfiguring Git aliases and identity..."
git config --global pull.rebase true
git config --global user.name "Shihab Mahamud"
git config --global user.email "shihab4t@gmail.com"

command="gh"

if ! command -v "$command" &>/dev/null; then
    echo -e "\nThe command '$command' does not exist."
    echo -e "\nInstalling '$command' (GitHub CLI)..."

    (type -p wget >/dev/null || (sudo apt update && sudo apt install -y wget)) &&
        sudo mkdir -p -m 755 /etc/apt/keyrings &&
        out=$(mktemp) && wget -nv -O "$out" https://cli.github.com/packages/githubcli-archive-keyring.gpg &&
        cat "$out" | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg >/dev/null &&
        sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg &&
        echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list >/dev/null &&
        sudo apt update &&
        sudo apt install -y gh
else
    echo -e "\nThe command '$command' already exists."
fi

echo -e "\nLogging into GitHub CLI..."
gh auth login
