#!/bin/bash

set -e

# Common Lisp LSP server: https://github.com/parenworks/sextant
# Requires SBCL and Quicklisp (~/quicklisp).

SEXTANT_DIR="$HOME/.local/share/sextant"

if ! command -v sbcl >/dev/null 2>&1; then
  sudo pacman -S --noconfirm sbcl
fi

if ! pacman -Q quicklisp >/dev/null 2>&1; then
  sudo pacman -S --noconfirm quicklisp
fi

# The pacman package only ships the bootstrap file, so set up ~/quicklisp once.
if [[ ! -f "$HOME/quicklisp/setup.lisp" ]]; then
  sbcl --non-interactive \
    --load /usr/share/quicklisp/quicklisp.lisp \
    --eval '(quicklisp-quickstart:install)'
fi

if [[ -d "$SEXTANT_DIR/.git" ]]; then
  git -C "$SEXTANT_DIR" pull --ff-only
else
  git clone https://github.com/parenworks/sextant "$SEXTANT_DIR"
fi

make -C "$SEXTANT_DIR"

mkdir -p "$HOME/.local/bin"
ln -sf "$SEXTANT_DIR/sextant" "$HOME/.local/bin/sextant"
