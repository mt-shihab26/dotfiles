#!/bin/bash

set -e

# https://todoist.com
# https://aur.archlinux.org/packages/todoist-appimage
omarchy pkg aur add todoist-appimage

# https://github.com/Doist/todoist-cli
# https://aur.archlinux.org/packages/todoist-cli
omarchy pkg aur add todoist-cli
