#!/bin/bash

set -e

POSTGRES_PASSWORD="2611"

echo "==> Installing PostgreSQL..."
sudo pacman -S --noconfirm postgresql

yay -S --noconfirm --needed pgvector

echo "==> Initializing PostgreSQL database..."
sudo -u postgres initdb --locale en_US.UTF-8 -D /var/lib/postgres/data

echo "==> Enabling and starting PostgreSQL service..."
sudo systemctl enable postgresql
sudo systemctl start postgresql

echo "==> Setting PostgreSQL password..."
sudo -u postgres psql -c "ALTER USER postgres PASSWORD '${POSTGRES_PASSWORD}';"

echo "==> Verifying PostgreSQL connection..."
PGPASSWORD="${POSTGRES_PASSWORD}" psql -U postgres -h localhost -c '\l'

echo "✅ PostgreSQL installed and password set to '${POSTGRES_PASSWORD}'"

# psql -U postgres -h localhost -W
