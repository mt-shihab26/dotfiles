#!/bin/env bash

set -e

echo -e "Add php 8.4 ppa..."
sudo LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php

echo -e "Updating package lists..."
sudo apt update

echo -e "Installing php..."
sudo apt install php8.4-cli php8.4-fpm

echo -e "Checking php fpm status"
sudo systemctl status php8.4-fpm | grep active

echo -e "\nInstalling common PHP extensions..."
sudo apt install php8.4-common php8.4-{bcmath,bz2,curl,gd,gmp,intl,mbstring,opcache,readline,xml,zip} php8.4-xdebug

# to changing php version
# sudo update-alternatives --config php
