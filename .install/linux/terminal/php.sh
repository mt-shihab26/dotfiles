#!/bin/env bash

set -e

echo -e "Updating package lists..."
sudo apt update

echo -e "\nInstalling PHP and Composer..."
sudo apt install -y php composer

echo -e "\nInstalling common PHP extensions..."
sudo apt install -y php-fpm php-cli php-curl php-mbstring php-mcrypt php-xml php-zip php-sqlite3 php-mysql php-pgsql php-redis php-gd

echo -e "\nInstalling Laravel Pint globally via Composer..."
composer global require laravel/pint

echo -e "\nInstalling Laravel installer globally via Composer..."
composer global require laravel/installer

echo -e "\nInstalling WP-CLI globally via Composer..."
composer global require wp-cli/wp-cli

echo -e "\nPHP installation complete."
