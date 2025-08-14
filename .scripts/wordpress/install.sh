#!/bin/bash

set -e

SITE_URL="https://atlas.test"
SITE_TITLE="Atlas"
ADMIN_USER="shihab"
ADMIN_PASSWORD="2611"
ADMIN_EMAIL="mt.shihab26@gmail.com"
DB_NAME="atlas"
DB_USER="root"
DB_PASSWORD="2611"

echo "Creating WordPress site in $(pwd)..."

wp core download

wp config create \
    --dbname="$DB_NAME" \
    --dbuser="$DB_USER" \
    --dbpass="$DB_PASSWORD" \
    --skip-check

wp db create

wp core install \
    --url="$SITE_URL" \
    --title="$SITE_TITLE" \
    --admin_user="$ADMIN_USER" \
    --admin_password="$ADMIN_PASSWORD" \
    --admin_email="$ADMIN_EMAIL"

echo "Removing all plugins..."
wp plugin delete --all

echo "Installing Elementor..."
wp plugin install elementor --activate

echo "Installing Duplicate Page plugin..."
wp plugin install duplicate-page --activate

echo "Installing and activating Hello Elementor theme..."
wp theme install hello-elementor --activate

echo "Removing all other themes..."
wp theme delete --all

echo "WordPress site created successfully!"
echo "Login at: $SITE_URL/wp-admin"
