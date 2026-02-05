echo "Install dependencies for building php8.4 with mise"
sudo pacman -Syu re2c autoconf automake libtool bison pkgconf openssl libxml2 sqlite curl oniguruma libzip icu

echo "Build and install php8.4 with mise"
mise install php@8.4

echo "Use php8.4 globally"
mise use -g php@8.4

echo "Build and install extension with pecl"
pecl install igbinary
pecl install redis

echo "------------------------------------"
echo "Please add the following settings to your php.ini file:"
echo "------------------------------------"
echo "extension=igbinary"
echo "extension=redis"
echo "------------------------------------"
