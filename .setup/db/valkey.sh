#!/bin/bash

set -e

# https://valkey.io/
# https://archlinux.org/packages/extra/x86_64/valkey/
omarchy pkg add valkey

sudo systemctl enable valkey
sudo systemctl start valkey
sudo systemctl status valkey

