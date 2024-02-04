#!/bin/bash

# put the names of your GTK themes here
# for example, here's mine
LIGHT_GTK_THEME='Adwaita'
DARK_GTK_THEME='Adwaita-dark'


CURRENT_THEME=$(gsettings get org.gnome.desktop.interface color-scheme)

if [[ "$CURRENT_THEME" == "'default'" ]]; then
	gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"
	gsettings set org.gnome.desktop.interface gtk-theme "$DARK_GTK_THEME"
else
	gsettings set org.gnome.desktop.interface color-scheme "default"
	gsettings set org.gnome.desktop.interface gtk-theme "$LIGHT_GTK_THEME"
fi
