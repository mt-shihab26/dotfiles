sudo pacman -S sassc gnome-themes-extra gtk-engine-murrine

git clone https://github.com/Fausto-Korpsvart/Tokyonight-GTK-Theme.git /tmp/TokyoNight
bash /tmp/TokyoNight/themes/install.sh
sudo mv ~/.themes/ /usr/share/themes/

sudo pacman -S nwg-look nautilus loupe totem fragments decibels snapshot gnome-clocks evince gedit

gsettings set org.gnome.desktop.interface gtk-theme "Tokyonight-Dark"
gsettings set org.gnome.desktop.interface monospace-font-name 'CaskaydiaMono Nerd Font 10'
