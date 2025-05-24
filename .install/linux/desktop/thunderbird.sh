#!/bin/bash

set -e

echo -e "Updating package list..."
sudo apt update

echo -e "\nInstalling Thunderbird..."
sudo apt install -y thunderbird

echo -e "\n✅ Thunderbird installation complete!"
