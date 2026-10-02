#!/bin/bash

set -e

# https://github.com/basecamp/fizzy-cli
# https://aur.archlinux.org/packages/fizzy-cli-bin
omarchy pkg aur add fizzy-cli-bin

# an empty icon fetches the site's own icon
omarchy webapp install Fizzy https://app.fizzy.do/session/menu ""
