#!/usr/bin/env bash

set -e

# Dependency for the hex view of binary files (.config/nvim/lua/lib/hex.lua)
# xxd turns the bytes into the hex dump and back. vim ships it too and conflicts with tinyxxd, so
# only install tinyxxd when no xxd is there yet
# tinyxxd: https://github.com/xyproto/tinyxxd https://archlinux.org/packages/extra/x86_64/tinyxxd/
if ! command -v xxd >/dev/null 2>&1; then
    omarchy pkg add tinyxxd
fi
