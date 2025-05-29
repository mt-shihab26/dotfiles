#!/bin/sh

# php-bcmath \
# php-bz2 \
# php-gmp \
# php-mysql \
# php-xdebug

sudo pacman -S php php-fpm php-gd php-intl php-redis php-sqlite php-mcrypt
sudo pacman -S composer nss jq xsel networkmanager nginx dnsmasq inotify-tools

composer global require laravel/pint
composer global require laravel/installer
composer global require cpriego/valet-linux

valet install

echo "\nAll the PHP extension have been installed."
echo "ls /usr/lib/php/modules"
ls /usr/lib/php/modules

echo ""
php --ini

echo "
# Add this to php.ini file

memory_limit = 512M
max_execution_time = 300
max_input_time = 300

extension=mysqli
"
