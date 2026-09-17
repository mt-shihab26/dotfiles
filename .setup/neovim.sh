#!/bin/bash

set -e

composer global require laravel/lsp
gem install ruby-lsp ruby-lsp-rails
bun install -g turbo-language-server
