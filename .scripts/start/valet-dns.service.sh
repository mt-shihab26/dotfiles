#!/usr/bin/env zsh

sudo systemctl start nginx.service
sudo systemctl start valet-dns.service
sudo systemctl start php-fpm.service
sudo systemctl start dnsmasq.service
