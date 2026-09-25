#!/bin/bash

set -e

omarchy pkg add valkey

sudo systemctl enable valkey
sudo systemctl start valkey
sudo systemctl status valkey

