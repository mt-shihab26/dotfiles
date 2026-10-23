#!/usr/bin/env bash

set -e

# https://todoist.com
# https://aur.archlinux.org/packages/todoist-appimage
omarchy pkg aur add todoist-appimage

# https://github.com/Doist/todoist-cli
# https://aur.archlinux.org/packages/todoist-cli
omarchy pkg aur add todoist-cli

# Install the Claude Code skill (~/.claude/skills/todoist-cli)
td skill install claude-code --force
