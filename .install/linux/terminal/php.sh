#!/bin/bash
set -e

# Install PHP
echo "Installing PHP..."
sudo apt update
sudo apt install -y php composer

# Check and install Composer if not found
# command_to_check="composer"
# if ! command -v "$command_to_check" &>/dev/null; then
#     echo "Composer not found. Installing Composer..."
#     cd /tmp
#     php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
#     php -r "if (hash_file('sha384', 'composer-setup.php') === 'dac665fdc30fdd8ec78b38b9800061b4150413ff2e3b6f88543c636f7cd84f6db9189d43a81e5503cda447da73c7e5b6') { echo 'Installer verified'.PHP_EOL; } else { echo 'Installer corrupt'.PHP_EOL; unlink('composer-setup.php'); exit(1); }"
#     php composer-setup.php
#     php -r "unlink('composer-setup.php');"
#     sudo mv composer.phar /usr/local/bin/composer
#     cd -
#     echo "Composer installed successfully."
# else
#     echo "The command '$command_to_check' already exists."
# fi

# Install Laravel installer globally
echo "Installing Laravel installer globally via Composer..."
composer global require laravel/installer
composer global require laravel/pint
