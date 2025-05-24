#!/bin/env bash

set -e

echo -e "Downloading Zoom..."
cd /tmp
wget https://zoom.us/client/latest/zoom_amd64.deb

echo -e "\nInstalling Zoom..."
sudo apt install -y ./zoom_amd64.deb

echo -e "\nCleaning up..."
rm zoom_amd64.deb
cd -

echo -e "\nZoom installation complete!"
