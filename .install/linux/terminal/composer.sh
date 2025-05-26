#!/bin/env bash

set -e

command="composer"

if ! command -v "$command" &>/dev/null; then
    echo -e "\nThe command '$command' does not exist."

    echo -e "\nInstalling Composer..."

    wget https://getcomposer.org/download/latest-stable/composer.phar

    sudo mv composer.phar /usr/local/bin/composer
    chmod +x /usr/local/bin/composer

    composer -v
else
    echo -e "\nThe command '$command' already exists."
fi

echo -e "\nInstalling Laravel Pint globally via Composer..."
composer global require laravel/pint

echo -e "\nInstalling Laravel installer globally via Composer..."
composer global require laravel/installer

echo -e "\Composer installation complete."
