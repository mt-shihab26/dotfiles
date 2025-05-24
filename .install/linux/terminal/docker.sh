#!/bin/env bash

set -e

echo -e "Installing Docker..."

echo -e "\nAdding Docker repository..."
sudo install -m 0755 -d /etc/apt/keyrings
sudo wget -qO /etc/apt/keyrings/docker.asc https://download.docker.com/linux/ubuntu/gpg
sudo chmod a+r /etc/apt/keyrings/docker.asc
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list >/dev/null
sudo apt update

echo -e "\nInstalling Docker engine and plugins..."
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin docker-ce-rootless-extras

echo -e "\nGranting current user Docker privileges..."
sudo usermod -aG docker ${USER}

echo -e "\nConfiguring Docker log limits..."
echo '{"log-driver":"json-file","log-opts":{"max-size":"10m","max-file":"5"}}' | sudo tee /etc/docker/daemon.json

echo -e "\nDocker installation complete."

# echo -e "\nTo run MySQL:"
# echo 'sudo docker run -d --restart unless-stopped -p "127.0.0.1:3306:3306" --name=mysql8 -e MYSQL_ROOT_PASSWORD= -e MYSQL_ALLOW_EMPTY_PASSWORD=true mysql:8.4'
#
# echo -e "\nTo run Redis:"
# echo 'sudo docker run -d --restart unless-stopped -p "127.0.0.1:6379:6379" --name=redis redis:7'
