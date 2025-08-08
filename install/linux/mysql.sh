#!/bin/sh

MYSQL_ROOT_PASSWORD="2611"

echo "==> Installing MariaDB..."
sudo pacman -Sy --noconfirm mariadb

echo "==> Initializing database..."
sudo mariadb-install-db --user=mysql --basedir=/usr --datadir=/var/lib/mysql

echo "==> Enabling and starting MariaDB service..."
sudo systemctl enable mariadb
sudo systemctl start mariadb

echo "==> Securing MariaDB and setting root password..."

sudo mariadb -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}'; FLUSH PRIVILEGES;"

echo "==> Verifying root login..."
mysql -u root -p${MYSQL_ROOT_PASSWORD} -e "STATUS"

if [ $? -eq 0 ]; then
    echo "✅ MariaDB installed and root password set to '${MYSQL_ROOT_PASSWORD}'"
else
    echo "❌ Something went wrong."
fi
