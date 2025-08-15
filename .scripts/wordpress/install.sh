#!/bin/bash

set -e

# Check at least 2 parameters
if [ "$#" -lt 1 ]; then
    echo "Usage: $0 <plugin_title> [--elementor] [--valet] [--updraftplus]"
    exit 1
fi

PLUGIN_TITLE="$1"
TARGET_PATH="$(pwd)" # Use current working directory
INSTALL_ELEMENTOR=false
USE_VALET=false
INSTALL_UPDRAFTPLUS=false

# Check optional flags (start from 2nd param)
for arg in "${@:2}"; do
    case "$arg" in
    --elementor)
        INSTALL_ELEMENTOR=true
        ;;
    --valet)
        USE_VALET=true
        ;;
    --updraftplus)
        USE_VALET=true
        ;;
    esac
done

# Slugify the plugin title: lowercase, replace spaces with hyphens, remove special chars
PLUGIN_SLUG=$(echo "$PLUGIN_TITLE" | tr '[:upper:]' '[:lower:]' | sed -E 's/[^a-z0-9]+/-/g' | sed -E 's/^-+|-+$//g')

# Underscore version for DB name
DB_NAME=$(echo "$PLUGIN_TITLE" | tr '[:upper:]' '[:lower:]' | sed -E 's/[^a-z0-9]+/_/g' | sed -E 's/^_+|_+$//g')

# WordPress configuration
SITE_URL="https://${PLUGIN_SLUG}.test"
SITE_TITLE="$PLUGIN_TITLE"
ADMIN_USER="shihab"
ADMIN_PASSWORD="2611"
ADMIN_EMAIL="mt.shihab26@gmail.com"
DB_USER="root"
DB_PASSWORD="2611"

# Create target directory
mkdir -p "$TARGET_PATH/$PLUGIN_SLUG"
cd "$TARGET_PATH/$PLUGIN_SLUG"

echo "Creating WordPress site in $(pwd)..."

# Download WordPress
wp core download

# Create wp-config.php
wp config create \
    --dbname="$DB_NAME" \
    --dbuser="$DB_USER" \
    --dbpass="$DB_PASSWORD" \
    --skip-check

# Function to append WP debug settings to wp-config.php
append_wp_debug_config() {
    cat <<'EOL' >>wp-config.php

// Enable WP_DEBUG mode
define('WP_DEBUG', true);

// Enable Debug logging to the /wp-content/debug.log file
define('WP_DEBUG_LOG', true);

// Disable display of errors and warnings
define('WP_DEBUG_DISPLAY', false);
@ini_set('display_errors', 0);
EOL
    echo "Debug configuration added to wp-config.php"
}

# Append debug settings
append_wp_debug_config

# Create database
wp db create

# Install WordPress
wp core install \
    --url="$SITE_URL" \
    --title="$SITE_TITLE" \
    --admin_user="$ADMIN_USER" \
    --admin_password="$ADMIN_PASSWORD" \
    --admin_email="$ADMIN_EMAIL" \
    --skip-email

# Remove all plugins
wp plugin delete --all

# Install Elementor only if flag is set
if [ "$INSTALL_ELEMENTOR" = true ]; then
    echo "Installing Elementor..."
    wp plugin install elementor --activate

    # Install Duplicate Page plugin
    wp plugin install duplicate-page --activate

    # Install Hello Elementor theme
    wp theme install hello-elementor --activate
fi

if [ "$INSTALL_UPDRAFTPLUS" = true ]; then
    echo "Installing UpdraftPlus..."
    wp plugin install updraftplus --activate
fi

# Remove all other themes
wp theme delete --all

# Run Valet commands if flag is set
if [ "$USE_VALET" = true ]; then
    echo "Running Valet commands..."
    valet link
    valet secure
    valet open
fi

echo "WordPress site created successfully!"
echo "Login at: $SITE_URL/wp-admin"

cd ~
