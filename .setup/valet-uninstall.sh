#!/bin/bash

set -e

if command -v valet >/dev/null 2>&1; then
    echo "Running valet uninstall..."
    valet uninstall
fi

echo "Removing leftover Valet Linux systemd units..."

# valet-linux's own `valet uninstall` restarts dnsmasq but never disables the
# service, leaving it enabled and crash-looping at every boot (it starts before
# systemd-resolved creates /run/systemd/resolve/, so it can't find its resolv-file).
sudo systemctl disable --now dnsmasq 2>/dev/null || true

# valet-linux installs this unit but never removes it on uninstall.
if [ -f /etc/systemd/system/valet-dns.service ]; then
    sudo systemctl disable --now valet-dns 2>/dev/null || true
    sudo rm -f /etc/systemd/system/valet-dns.service
fi

sudo systemctl daemon-reload

echo "Removing Valet Linux leftover files..."
sudo rm -rf /opt/valet-linux
rm -rf "$HOME/.config/valet"

echo "Removing Valet Linux composer package..."
composer global remove cpriego/valet-linux 2>/dev/null || true

# valet-linux's DnsMasq::uninstall() force-symlinks /etc/resolv.conf to
# /run/systemd/resolve/resolv.conf (uplink mode) instead of restoring
# systemd-resolved's stub resolver (/run/systemd/resolve/stub-resolv.conf).
# Uplink mode skips systemd-resolved's stub listener and can race with
# NetworkManager's connectivity check on networks with broken IPv6, showing
# "limited" connectivity at boot. Switch back to stub mode:
#   sudo ln -sf /run/systemd/resolve/stub-resolv.conf /etc/resolv.conf

echo "Valet Linux fully removed."
