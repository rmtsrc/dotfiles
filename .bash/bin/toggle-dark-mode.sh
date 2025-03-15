#!/usr/bin/env bash

if [[ "$DESKTOP_SESSION" == "plasma" ]]; then
  LIGHT_KDE_THEME='org.kde.breeze.desktop'
  DARK_KDE_THEME='org.kde.breezedark.desktop'

  if grep -q "$DARK_KDE_THEME" ~/.config/kdeglobals; then
    lookandfeeltool -a $LIGHT_KDE_THEME
  else
    lookandfeeltool -a $DARK_KDE_THEME
  fi
fi

if [[ "$DESKTOP_SESSION" == "gnome" ]]; then
  LIGHT_GTK_THEME='Adwaita'
  DARK_GTK_THEME='Adwaita-dark'

  CURRENT_THEME=$(gsettings get org.gnome.desktop.interface color-scheme)

  SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
  EXTRA_SCRIPT="$SCRIPT_DIR/toggle-dark-mode.extra.sh"

  if [[ "$CURRENT_THEME" == "'default'" ]]; then
    gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"
    gsettings set org.gnome.desktop.interface gtk-theme "$DARK_GTK_THEME"

    if [ -f "$EXTRA_SCRIPT" ]; then
      bash "$EXTRA_SCRIPT" dark
    fi
  else
    gsettings set org.gnome.desktop.interface color-scheme "default"
    gsettings set org.gnome.desktop.interface gtk-theme "$LIGHT_GTK_THEME"

    if [ -f "$EXTRA_SCRIPT" ]; then
      bash "$EXTRA_SCRIPT" light
    fi
  fi
fi

KONSOLE_CONFIG=~/.config/konsolerc
if [ -f $KONSOLE_CONFIG ]; then
  if grep -q "DefaultProfile=Light" $KONSOLE_CONFIG; then
    sed -i "s/DefaultProfile=Light/DefaultProfile=Dark/g" $KONSOLE_CONFIG
    [[ "$DESKTOP_SESSION" == "gnome" ]] && sed -i "s/ColorScheme=KvGnome$/ColorScheme=KvGnomeDark/g" $KONSOLE_CONFIG
  else
    sed -i "s/DefaultProfile=Dark/DefaultProfile=Light/g" $KONSOLE_CONFIG
    [[ "$DESKTOP_SESSION" == "gnome" ]] && sed -i "s/ColorScheme=KvGnomeDark$/ColorScheme=KvGnome/g" $KONSOLE_CONFIG
  fi
fi
