#!/bin/bash

yay -S typesense-bin

sudo systemctl start typesense-server.service
sudo systemctl enable typesense-server.service
