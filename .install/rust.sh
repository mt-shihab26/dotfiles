#!/bin/bash

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

rustup default stable

rustup toolchain install

rustup component add rustfmt
rustup component add rust-analyzer
