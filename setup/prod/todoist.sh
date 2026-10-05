#!/bin/bash

set -e

# https://todoist.com
# https://aur.archlinux.org/packages/todoist-appimage
omarchy pkg aur add todoist-appimage

# https://github.com/Doist/todoist-cli
# https://aur.archlinux.org/packages/todoist-cli
omarchy pkg aur add todoist-cli

# Install the Claude Code skill (~/.claude/skills/todoist-cli) and link it into both Claude profiles
td skill install claude-code --force
for profile in personal professional; do
    mkdir -p "$HOME/.config/claude/$profile/skills"
    ln -sfn "$HOME/.claude/skills/todoist-cli" "$HOME/.config/claude/$profile/skills/todoist-cli"
done
