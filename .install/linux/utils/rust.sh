#!/bin/bash

sudo pacman -S rustup

rustup toolchain install
rustup component add rustfmt
