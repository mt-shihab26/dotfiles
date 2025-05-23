#!/bin/bash

MYSQL_ROOT_PASSWORD="2611"

sudo apt update

echo "[INFO] Pre-configuring MySQL root password..."
echo "mysql-server mysql-server/root_password password $MYSQL_ROOT_PASSWORD" | sudo debconf-set-selections
echo "mysql-server mysql-server/root_password_again password $MYSQL_ROOT_PASSWORD" | sudo debconf-set-selections

echo "[INFO] Installing MySQL Server..."
sudo DEBIAN_FRONTEND=noninteractive apt install -y mysql-server

echo "[INFO] Configuring MySQL root user password..."
sudo mysql -u root <<EOF
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '$MYSQL_ROOT_PASSWORD';
FLUSH PRIVILEGES;
EOF

echo "[INFO] Securing MySQL installation..."
sudo mysql -u root -p"$MYSQL_ROOT_PASSWORD" <<EOF
DELETE FROM mysql.user WHERE User='';
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';
FLUSH PRIVILEGES;
EOF

echo "[INFO] Enabling and starting MySQL service..."
sudo systemctl enable mysql
sudo systemctl start mysql

echo "[SUCCESS] MySQL installation and configuration completed."
