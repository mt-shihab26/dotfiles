#!/bin/bash

MYSQL_ROOT_PASSWORD="2611"

echo -e "\nUpdating package list..."
sudo apt update

echo -e "\nPre-configuring MySQL root password..."
echo "mysql-server mysql-server/root_password password $MYSQL_ROOT_PASSWORD" | sudo debconf-set-selections
echo "mysql-server mysql-server/root_password_again password $MYSQL_ROOT_PASSWORD" | sudo debconf-set-selections

echo -e "\nInstalling MySQL Server..."
sudo DEBIAN_FRONTEND=noninteractive apt install -y mysql-server

echo -e "\nConfiguring MySQL root user password..."
sudo mysql -u root <<EOF
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '$MYSQL_ROOT_PASSWORD';
FLUSH PRIVILEGES;
EOF

echo -e "\nSecuring MySQL installation..."
sudo mysql -u root -p"$MYSQL_ROOT_PASSWORD" <<EOF
DELETE FROM mysql.user WHERE User='';
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';
FLUSH PRIVILEGES;
EOF

echo -e "\nEnabling and starting MySQL service..."
sudo systemctl enable mysql
sudo systemctl start mysql

echo -e "\nMySQL installation and configuration completed.\n"
