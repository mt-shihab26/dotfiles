#!/usr/bin/env bash

TARGET_DIR="$(realpath ../nvim-v1)"
LINK_NAME="$(realpath ../)/nvim"

rm "$LINK_NAME"
ln -s "$TARGET_DIR" "$LINK_NAME"
