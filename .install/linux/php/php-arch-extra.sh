echo "Installing PHP and essential extensions..."
sudo pacman -S php php-fpm php-gd php-intl php-redis php-sqlite php-sodium xdebug php-pgsql imagemagick

echo "Installing Composer and system utilities..."
sudo pacman -S composer nginx dnsmasq inotify-tools rsync nss jq xsel networkmanager

echo "Installing PHP ImageMagick extension from AUR..."
yay -S php-imagick --noconfirm

echo "Enable php fpm on systemd..."
sudo systemctl enable php-fpm
sudo systemctl start php-fpm

echo "Listing PHP loaded modules:"
php -m

echo "Listing PHP installed modules"
ls /usr/lib/php/modules

echo "PHP configuration info:"
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
echo "extension=igbinary"
echo "extension=redis"
echo "extension=iconv"
echo "extension=sodium"
echo "extension=pgsql"
echo "extension=pdo_pgsql"
echo "extension=exif"
echo "extension=imagick"

echo "Please add the following settings to your /etc/php/conf.d/xdebug.ini file:"
echo "------------------------------------"
echo "zend_extension=xdebug.so"
echo "xdebug.mode=debug,coverage"
