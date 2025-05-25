#!/bin/env bash

set -e

echo -e "Updating package lists..."
brew update

echo -e "\nInstalling PHP and Composer..."
brew install php composer

echo -e "\nInstalling common PHP extensions..."
brew install \
    php-fpm \
    php-cli \
    php-curl \
    php-mbstring \
    php-mcrypt \
    php-xml \
    php-zip \
    php-sqlite3 \
    php-mysql \
    php-pgsql \
    php-redis \
    php-gd \
    php-bcmath \
    php-intl \
    php-soap \
    php-readline \
    php-tokenizer \
    php-opcache \
    php-common \
    php-dev \
    php-imap \
    php-exif \
    php-fileinfo

echo -e "\nInstalling Laravel Pint globally via Composer..."
composer global require laravel/pint

echo -e "\nInstalling Laravel installer globally via Composer..."
composer global require laravel/installer

echo -e "\nInstalling WP-CLI globally via Composer..."
composer global require wp-cli/wp-cli

echo -e "\nPHP installation complete."
