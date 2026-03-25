#!/usr/bin/env bash
set -euo pipefail

# GNOME
GSETTINGS=$(command -v gsettings || true)

# KDE
LOOKANDFEEL=$(command -v lookandfeeltool || true)

if [[ -n "$LOOKANDFEEL" ]]; then
  LIGHT_KDE_THEME='org.kde.breeze.desktop'
  DARK_KDE_THEME='org.kde.breezedark.desktop'

  if grep -q "$DARK_KDE_THEME" ~/.config/kdeglobals 2>/dev/null; then
    "$LOOKANDFEEL" -a "$LIGHT_KDE_THEME"
    MODE="light"
  else
    "$LOOKANDFEEL" -a "$DARK_KDE_THEME"
    MODE="dark"
  fi
fi

if [[ -n "$GSETTINGS" ]]; then
  CURRENT_SCHEME=$("$GSETTINGS" get org.gnome.desktop.interface color-scheme)
  if [[ "$CURRENT_SCHEME" == "'default'" ]]; then
    "$GSETTINGS" set org.gnome.desktop.interface color-scheme "prefer-dark"
    "$GSETTINGS" set org.gnome.desktop.interface gtk-theme "Adwaita-dark"

    MODE="dark"
  else
    "$GSETTINGS" set org.gnome.desktop.interface color-scheme "default"
    "$GSETTINGS" set org.gnome.desktop.interface gtk-theme "Adwaita"

    MODE="light"
  fi
fi

# Optional hook
SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
EXTRA_SCRIPT="$SCRIPT_DIR/toggle-dark-mode.extra.sh"
if [[ -f "$EXTRA_SCRIPT" ]]; then
  bash "$EXTRA_SCRIPT" "$MODE"
fi
