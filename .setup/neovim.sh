#!/bin/bash

set -e

gem install ruby-lsp ruby-lsp-rails
gem install rubocop rubocop-rails
bun install -g turbo-language-server

