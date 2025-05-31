#!/bin/sh

yay -S sddm-astronaut-theme

ls /usr/share/sddm/themes/

sudo ln -s $HOME/.config/sddm/sddm.conf /etc/sddm.conf

cat /etc/sddm.conf
