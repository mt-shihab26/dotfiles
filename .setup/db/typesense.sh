#!/bin/bash

set -e

omarchy pkg aur add typesense-bin

sudo systemctl start typesense-server.service
sudo systemctl enable typesense-server.service

sudo cat /etc/typesense/typesense-server.ini

