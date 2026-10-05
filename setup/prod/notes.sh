#!/bin/bash

set -e

REPO_DIR="$HOME/Notes"

if [ -d "$REPO_DIR" ]; then
    echo "==> $REPO_DIR already exists, skipping clone"
else
    echo "==> Cloning Notes repo..."
    git clone https://github.com/mt-shihab26/Notes.git "$REPO_DIR"
fi

echo "==> Enabling notes-autocommit timer..."
systemctl --user enable --now notes-autocommit.timer

echo "Notes repo ready and autocommit timer enabled"
