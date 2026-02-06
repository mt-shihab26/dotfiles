#!/bin/bash

sudo pacman -S valkey

sudo systemctl enable valkey
sudo systemctl start valkey
sudo systemctl status valkey
