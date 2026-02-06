#!/bin/sh

curl -O https://github.com/php/pie/releases/latest/download/pie.phar

chmod +x pie.phar
#
sudo mv pie.phar /usr/local/bin/pie
