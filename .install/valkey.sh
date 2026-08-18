#!/bin/bash

sudo pacman -S --noconfirm valkey

sudo systemctl enable valkey
sudo systemctl start valkey
sudo systemctl status valkey

