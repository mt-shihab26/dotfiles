#!/bin/bash

set -e

for gem in ruby-lsp ruby-lsp-rails rubocop rubocop-rails; do
  if ! gem list -i "$gem" >/dev/null 2>&1; then
    gem install "$gem"
  fi
done

if ! command -v turbo-language-server >/dev/null 2>&1; then
  bun install -g turbo-language-server
fi

# Common Lisp
"$(dirname "$0")/sextant.sh"
