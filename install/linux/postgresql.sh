#!/bin/sh

POSTGRES_PASSWORD="2611"

# Update package database
sudo pacman -Syy

# === Install PostgreSQL ===
echo "==> Installing PostgreSQL..."
sudo pacman -S --noconfirm postgresql

yay -S --noconfirm --needed pgvector

# Initialize PostgreSQL database
echo "==> Initializing PostgreSQL database..."
sudo -u postgres initdb --locale en_US.UTF-8 -D /var/lib/postgres/data

# Enable and start PostgreSQL service
echo "==> Enabling and starting PostgreSQL service..."
sudo systemctl enable postgresql
sudo systemctl start postgresql

# Set PostgreSQL password
echo "==> Setting PostgreSQL password..."
sudo -u postgres psql -c "ALTER USER postgres PASSWORD '${POSTGRES_PASSWORD}';"

# Verify PostgreSQL connection
echo "==> Verifying PostgreSQL connection..."
PGPASSWORD="${POSTGRES_PASSWORD}" psql -U postgres -h localhost -c '\l'

if [ $? -eq 0 ]; then
    echo "✅ PostgreSQL installed and password set to '${POSTGRES_PASSWORD}'"
else
    echo "❌ PostgreSQL setup failed."
fi

# psql -U postgres -h localhost -W
