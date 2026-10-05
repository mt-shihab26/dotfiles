#!/bin/bash

set -e

greet() {
    local name="$1"
    echo "Hello, $name!"
}

sum() {
    local total=0 n
    for n in "$@"; do
        total=$((total + n))
    done
    echo "$total"
}

names=("world" "Neovim")

for name in "${names[@]}"; do
    greet "$name"
done

if [[ $(sum 1 2 3) -eq 6 ]]; then
    echo "sum works"
fi
