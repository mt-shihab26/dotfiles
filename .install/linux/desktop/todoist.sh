#!/bin/env bash

sudo nala update
sudo nala install snapd
sudo snap install todoist
sudo snap set core experimental.refresh-app-awareness=true
