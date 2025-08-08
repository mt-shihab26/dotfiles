#!/bin/sh

sudo pacman -S git github-cli less

git config --global pull.rebase true
git config --global init.defaultBranch "main"
git config --global user.name "Shihab Mahamud"
git config --global user.email "shihab4t@gmail.com"

# gh auth login
