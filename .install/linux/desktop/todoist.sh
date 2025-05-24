#!/bin/env bash

sudo apt update
sudo apt install snapd
sudo snap install todoist
sudo snap set core experimental.refresh-app-awareness=true
