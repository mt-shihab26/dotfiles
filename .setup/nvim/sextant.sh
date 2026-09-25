#!/bin/bash

set -e

# Common Lisp LSP server: https://github.com/parenworks/sextant
# Requires SBCL and Quicklisp (~/quicklisp).

SEXTANT_DIR="$HOME/.local/share/sextant"

omarchy pkg add sbcl quicklisp

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

if [[ ! -d "$HOME/.local/bin" ]]; then
    mkdir -p "$HOME/.local/bin"
fi
if [[ ! -e "$HOME/.local/bin/sextant" && ! -L "$HOME/.local/bin/sextant" ]]; then
    ln -s "$SEXTANT_DIR/sextant" "$HOME/.local/bin/sextant"
fi
