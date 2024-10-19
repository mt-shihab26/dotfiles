#!/bin/bash

if [ "$1" = "clean" ]; then
    rm -rf ~/.local/slate/nvim
    rm -rf ~/.local/share/nvim
fi
