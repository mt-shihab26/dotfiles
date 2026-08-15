#!/bin/bash

sudo pacman -Sy --noconfirm opencode
yay -Sy --noconfirm --needed claude-code
sudo pacman -Sy --noconfirm openai-codex
yay -Sy --noconfirm --needed github-copilot-cli-bin
