#!/usr/bin/env bash
set -euo pipefail

# Usage: toggle-dark-mode.sh [light|dark]
# If no argument is provided, it will toggle based on the current state.

# Tools
GSETTINGS=$(command -v gsettings || true)
LOOKANDFEEL=$(command -v lookandfeeltool || true)

# Determine the Target Mode
# Priority: Argument ($1) > Detection > Default (light)
INPUT_ARG="${1:-}"
TARGET_MODE=""

case "$INPUT_ARG" in
  light|dark)
    TARGET_MODE="$INPUT_ARG"
    ;;
esac

if [[ -z "$TARGET_MODE" ]]; then
  # No valid argument provided: Perform Toggle Logic
  if [[ -n "$LOOKANDFEEL" ]]; then
    # KDE Detection
    if grep -q "org.kde.breezedark.desktop" ~/.config/kdeglobals 2>/dev/null; then
      TARGET_MODE="light"
    else
      TARGET_MODE="dark"
    fi
  elif [[ -n "$GSETTINGS" ]]; then
    # GNOME Detection
    CURRENT_SCHEME=$($GSETTINGS get org.gnome.desktop.interface color-scheme)
    if [[ "$CURRENT_SCHEME" == "'prefer-dark'" ]]; then
      TARGET_MODE="light"
    else
      TARGET_MODE="dark"
    fi
  fi
fi

# KDE Apply
if [[ -n "$LOOKANDFEEL" ]]; then
  THEME=$([[ "$TARGET_MODE" == "dark" ]] && echo "org.kde.breezedark.desktop" || echo "org.kde.breeze.desktop")
  "$LOOKANDFEEL" -a "$THEME"
fi

# GNOME Apply
if [[ -n "$GSETTINGS" ]]; then
  SCHEME=$([[ "$TARGET_MODE" == "dark" ]] && echo "prefer-dark" || echo "default")
  THEME=$([[ "$TARGET_MODE" == "dark" ]] && echo "Adwaita-dark" || echo "Adwaita")

  "$GSETTINGS" set org.gnome.desktop.interface color-scheme "$SCHEME"
  "$GSETTINGS" set org.gnome.desktop.interface gtk-theme "$THEME"
fi

# Optional hook
SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
EXTRA_SCRIPT="$SCRIPT_DIR/toggle-dark-mode.extra.sh"
if [[ -f "$EXTRA_SCRIPT" ]]; then
  bash "$EXTRA_SCRIPT" "$TARGET_MODE"
fi
