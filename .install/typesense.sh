#!/bin/bash

set -e

yay -S --noconfirm typesense-bin

sudo systemctl start typesense-server.service
sudo systemctl enable typesense-server.service

sudo cat /etc/typesense/typesense-server.ini

