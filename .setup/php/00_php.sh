#!/bin/bash

set -e

echo "Installing PHP and essential packages..."
# php: https://www.php.net/ https://archlinux.org/packages/extra/x86_64/php/
# php-fpm: https://www.php.net/ https://archlinux.org/packages/extra/x86_64/php-fpm/
# php-gd: https://www.php.net/ https://archlinux.org/packages/extra/x86_64/php-gd/
# php-intl: provided by php
# php-redis: https://github.com/phpredis/phpredis/ https://archlinux.org/packages/extra/x86_64/php-redis/
# php-sqlite: https://www.php.net/ https://archlinux.org/packages/extra/x86_64/php-sqlite/
# php-sodium: https://www.php.net/ https://archlinux.org/packages/extra/x86_64/php-sodium/
# php-pgsql: https://www.php.net/ https://archlinux.org/packages/extra/x86_64/php-pgsql/
# xdebug: https://www.xdebug.org https://archlinux.org/packages/extra/x86_64/xdebug/
# imagemagick: https://www.imagemagick.org/ https://archlinux.org/packages/extra/x86_64/imagemagick/
# composer: https://getcomposer.org/ https://archlinux.org/packages/extra/any/composer/
# nginx: https://nginx.org https://archlinux.org/packages/extra/x86_64/nginx/
# dnsmasq: http://www.thekelleys.org.uk/dnsmasq/doc.html https://archlinux.org/packages/extra/x86_64/dnsmasq/
# inotify-tools: https://github.com/inotify-tools/inotify-tools https://archlinux.org/packages/extra/x86_64/inotify-tools/
# rsync: https://rsync.samba.org/ https://archlinux.org/packages/extra/x86_64/rsync/
# nss: https://firefox-source-docs.mozilla.org/security/nss/index.html https://archlinux.org/packages/core/x86_64/nss/
# jq: https://jqlang.github.io/jq/ https://archlinux.org/packages/extra/x86_64/jq/
# xsel: https://vergenet.net/~conrad/software/xsel/ https://archlinux.org/packages/extra/x86_64/xsel/
# networkmanager: https://networkmanager.dev/ https://archlinux.org/packages/extra/x86_64/networkmanager/
omarchy pkg add php php-fpm php-gd php-intl php-redis php-sqlite php-sodium php-pgsql \
    xdebug imagemagick composer nginx dnsmasq inotify-tools rsync nss jq xsel networkmanager

echo "Installing PHP ImageMagick extension from AUR..."
# https://github.com/imagick/imagick
# https://archlinux.org/packages/extra/x86_64/php-imagick/
omarchy pkg aur add php-imagick

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
echo "extension=intl"
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
