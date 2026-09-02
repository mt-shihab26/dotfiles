#!/bin/bash

set -e

echo "Installing Laravel tools globally..."

composer global require laravel/pint
composer global require laravel/installer
