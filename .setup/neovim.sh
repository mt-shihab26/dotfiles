#!/bin/bash

set -e

composer global require laravel/lsp
bun install -g turbo-language-server
