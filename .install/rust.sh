#!/bin/bash

sudo pacman -S rustup

rustup default stable

rustup toolchain install

rustup component add rustfmt
