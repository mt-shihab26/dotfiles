#!/bin/sh

sudo pacman -Syu
sudo pacman -S git

git config --global pull.rebase true
git config --global user.name "Shihab Mahamud"
git config --global user.email "shihab4t@gmail.com"

# gh auth login
