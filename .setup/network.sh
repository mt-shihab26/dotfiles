#!/bin/bash

set -e

# Home router hands out a global IPv6 address via SLAAC but has no real IPv6
# route to the internet. NetworkManager's connectivity check can race on that
# broken IPv6 path right after boot and cache a false "limited" connectivity
# state until the next periodic check. Disabling IPv6 on this connection
# removes the race entirely.
connection=$(nmcli -t -f NAME,TYPE connection show --active | grep ':802-11-wireless$' | cut -d: -f1 | head -n1)

if [ -z "$connection" ]; then
    echo "No active wifi connection found."
    exit 1
fi

# ipv6.dns must be cleared before method=disabled is allowed.
nmcli connection modify "$connection" ipv6.dns "" ipv6.ignore-auto-dns no ipv6.method disabled
