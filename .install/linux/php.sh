#!/bin/sh

echo "===================================="
echo "Installing PHP and essential extensions..."
echo "===================================="

sudo pacman -S php php-fpm php-gd php-intl php-redis php-sqlite

sudo systemctl enable php-fpm
sudo systemctl start php-fpm

echo "===================================="
echo "Installing Composer and system utilities..."
echo "===================================="

sudo pacman -S composer nginx dnsmasq inotify-tools rsync nss jq xsel networkmanager

echo "===================================="
echo "Installing frankenphp from aur..."
echo "===================================="

yay -S frankenphp

echo "===================================="
echo "Installing Laravel tools globally..."
echo "===================================="

composer global require laravel/pint
composer global require laravel/installer
composer global require cpriego/valet-linux

# echo "===================================="
# echo "Running Valet installation..."
# echo "===================================="

# valet install

echo "===================================="
echo "PHP loaded modules:"
echo "===================================="
php -m

echo "===================================="
echo "✅ All PHP extensions have been installed."
echo "📁 Listing PHP module files in /usr/lib/php/modules:"
echo "===================================="
ls /usr/lib/php/modules

echo "===================================="
echo "🔧 PHP configuration info:"
echo "===================================="
php --ini

echo "===================================="
echo "Please add the following settings to your php.ini file:"
echo "------------------------------------"
echo "memory_limit = 2048M"
echo "max_execution_time = 24000"
echo "max_input_time = 24000"
echo "# Enable extensions"
echo "extension=sqlite3"
echo "extension=pdo_sqlite"
echo "extension=mysqli"
echo "extension=pdo_mysql"
echo "extension=gd"
echo "extension=bcmath"
echo "extension=igbinary"
echo "extension=redis"
echo "extension=iconv"
echo "===================================="

echo "===================================="
echo " Then run '\$ valet install'"
echo "===================================="
