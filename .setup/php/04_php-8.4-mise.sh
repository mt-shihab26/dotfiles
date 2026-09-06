#!/bin/bash

set -e

echo "Install dependencies for building php8.4 with mise"
sudo pacman -S re2c gd

echo "Build and install php8.4 with mise"
CONFIGURE_OPTS="--with-gmp" mise install php@8.4

echo "Use php8.4 globally"
mise use -g php@8.4

echo "Build and install extension with pecl"
pecl install igbinary
pecl install redis

# echo "Create a real PHP binary symlink in /usr/local/bin"
# sudo ln -sf ~/.local/share/mise/shims/php /usr/local/bin/php
# sudo ln -sf ~/.local/share/mise/shims/php-fpm /usr/local/bin/php-fpm

echo "PHP configuration paths:"
php --ini

echo "------------------------------------"
echo "Please add the following settings to your php.ini file:"
echo "------------------------------------"
echo "extension=igbinary"
echo "extension=redis"
echo "------------------------------------"

mise unuse -g php@8.4
