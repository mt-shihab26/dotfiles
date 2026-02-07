#!/bin/bash

echo "Installing PHP and essential packages..."
sudo pacman -S php php-fpm php-gd php-intl php-redis php-sqlite php-sodium php-pgsql \
    xdebug imagemagick composer nginx dnsmasq inotify-tools rsync nss jq xsel networkmanager

echo "Installing PHP ImageMagick extension from AUR..."
yay -S php-imagick --noconfirm

echo "Enable php fpm on systemd..."
sudo systemctl enable php-fpm
sudo systemctl start php-fpm

# echo "Listing PHP loaded modules:"
# php -m

# echo "Listing PHP installed modules"
# ls /usr/lib/php/modules

echo "PHP configuration files paths:"
php --ini

echo "Please add the following settings to your php.ini file:"
echo "------------------------------------"
echo "memory_limit = 2048M"
echo "max_execution_time = 24000"
echo "max_input_time = 24000"
echo "upload_max_filesize = 64M"
echo "# Enable extensions"
echo "extension=sqlite3"
echo "extension=pdo_sqlite"
echo "extension=mysqli"
echo "extension=pdo_mysql"
echo "extension=gd"
echo "extension=bcmath"
echo "extension=iconv"
echo "extension=sodium"
echo "extension=pgsql"
echo "extension=pdo_pgsql"
echo "extension=exif"
echo "------------------------------------"

echo "Please add the following settings to your /etc/php/conf.d/igbinary.ini file:"
echo "------------------------------------"
echo "extension=igbinary"
echo "------------------------------------"

echo "Please add the following settings to your /etc/php/conf.d/imagick.ini file:"
echo "------------------------------------"
echo "extension=imagick"
echo "------------------------------------"

echo "Please add the following settings to your /etc/php/conf.d/redis.ini file:"
echo "------------------------------------"
echo "extension=redis"
echo "------------------------------------"

echo "Please add the following settings to your /etc/php/conf.d/xdebug.ini file:"
echo "------------------------------------"
echo "zend_extension=xdebug.so"
echo "xdebug.mode=debug,coverage"
echo "------------------------------------"
