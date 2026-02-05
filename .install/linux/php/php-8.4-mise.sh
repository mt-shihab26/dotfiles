echo "Build and install php8.4 with mise"
mise install php@8.4

echo "Use php8.4 globally"
mise use -g php@8.4

pecl install igbinary
pecl install redis
