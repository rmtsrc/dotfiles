#!/usr/bin/env bash

# Usage ./screen-volume.sh Up/+/Down/- optional-display-volume

# Examples:
# ./screen-volume.sh Down
# ./screen-volume.sh 10
# ./screen-volume.sh 100

# Setup
# 1. Install `ddcutil`
# 2. Load i2c: `sudo modprobe i2c-dev`
# 3. Enable i2c at boot, add `i2c-dev` to: `/etc/modules-load.d/modules.conf`
# 4. Allow non-root display access, add: `/etc/udev/rules.d/45-ddcutil-i2c.rules`
#      KERNEL=="i2c-[0-9]*", GROUP="your-user", MODE="0660", PROGRAM="/usr/bin/ddcutil --bus=%n getvcp 0x10"
# 5. Reload rules: `sudo udevadm trigger`
# 6. Find your monitor bus code: `ddcutil detect` # /dev/i2c-17 in my case
# 7. Check what features can be controlled: `ddcutil capabilities --bus=17`
# 8. Test get brightness: `ddcutil --bus=17 getvcp 10`
# 9. Test set brightness 30%: `ddcutil --bus=17 setvcp 10 30`
# 10. Update MONITOR= to match you monitor bus number

# Stop on error
set -e

STEP=25    # Step Up/Down volume by: 25%
FEATURE=62 # Volume

if [[ "$1" =~ ^[0-9]+$ ]]; then
  NewValue=$1
else
  CurValue=$(ddcutil -t getvcp $FEATURE)
  CurValue="$(echo $CurValue | awk '{print $4}')"
  [[ "$1" == "Up" || "$1" == "+" ]] && NewValue=$((CurValue + STEP))
  [[ "$1" == "Down" || "$1" == "-" ]] && NewValue=$((CurValue - STEP))
fi

[[ "$NewValue" -lt 10 ]] && NewValue=0    # Negative not allowed
[[ "$NewValue" -gt 100 ]] && NewValue=100 # Can't go over 100

ddcutil setvcp $FEATURE $NewValue # Set new volume
