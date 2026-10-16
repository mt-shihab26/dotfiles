#!/usr/bin/env bash

set -e

# Dependency for reverse debugging C/C++/Rust with nvim-dap-rr (.config/nvim/lua/debuggers/native.lua)
# rr: https://rr-project.org/ https://aur.archlinux.org/packages/rr-bin
omarchy pkg aur add rr-bin

# rr reads cpu performance counters, which the kernel only allows with perf_event_paranoid <= 1
echo "kernel.perf_event_paranoid = 1" | sudo tee /etc/sysctl.d/10-rr.conf >/dev/null
sudo sysctl -p /etc/sysctl.d/10-rr.conf
