#!/bin/bash

set -e

omarchy pkg aur add fizzy-cli-bin

# an empty icon fetches the site's own icon
omarchy webapp install Fizzy https://app.fizzy.do/session/menu ""
