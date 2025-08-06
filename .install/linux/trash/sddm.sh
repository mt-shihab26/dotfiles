#!/bin/sh

echo "Installing the sddm-astronaut-theme with yay..."
yay -S sddm-astronaut-theme

echo "Listing available SDDM themes..."
ls /usr/share/sddm/themes/

echo "Linking your custom sddm.conf to /etc/sddm.conf..."
sudo ln -s $HOME/.config/sddm/sddm.conf /etc/sddm.conf

echo "Displaying the contents of /etc/sddm.conf..."
cat /etc/sddm.conf

echo "============================================="
echo "TO SELECT A THEME:"
echo "Edit the following file:"
echo "/usr/share/sddm/themes/sddm-astronaut-theme/metadata.desktop"
echo
echo "Find and add this line:"
echo "ConfigFile=Themes/astronaut.conf"
echo
echo "Available theme configurations:"
ls /usr/share/sddm/themes/sddm-astronaut-theme/Themes/
echo "============================================="
