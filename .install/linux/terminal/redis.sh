#!/bin/env bash

set -e

echo -e "Updating package index..."
sudo nala update

echo -e "\nInstalling Redis server..."
sudo nala install -y redis-server

echo -e "\nEnabling and starting Redis service..."
sudo systemctl enable redis-server
sudo systemctl start redis-server

echo -e "\nChecking Redis status..."
sudo systemctl status redis-server | grep Active

echo -e "\nTesting Redis with ping..."
redis-cli ping

echo -e "\nRedis installation and basic check complete."
