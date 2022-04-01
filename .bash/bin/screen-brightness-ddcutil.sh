#!/usr/bin/env bash

# Usage ./screen-brightness-ddcutil.sh Up/+/Down/- optional-display-brightness

# Examples:
# ./screen-brightness-ddcutil.sh Down
# ./screen-brightness-ddcutil.sh 10
# ./screen-brightness-ddcutil.sh 100

# Setup
# 1. Install `ddcutil`
# 2. Load i2c: `sudo modprobe i2c-dev`
# 3. Enable i2c at boot, add `i2c-dev` to: `/etc/modules-load.d/modules.conf`
# 4a i. Allow non-root display access, add: `/etc/udev/rules.d/45-ddcutil-i2c.rules`
#      KERNEL=="i2c-[0-9]*", GROUP="your-user", MODE="0660", PROGRAM="/usr/bin/ddcutil --bus=%n getvcp 0x10"
# 4a ii. Reload rules: `sudo udevadm trigger`
# 4b. Or allow user access to `i2c` group `sudo usermod -a -G i2c $USER`
# 5. Find your monitor bus code: `ddcutil detect` # /dev/i2c-17 in my case
# 6. Check what features can be controlled: `ddcutil capabilities --bus=17`
# 7. Test get brightness: `ddcutil --bus=17 getvcp 10`
# 8. Test set brightness 30%: `ddcutil --bus=17 setvcp 10 30`
# 9. Update MONITOR= to match you monitor bus number

# Stop on error
set -e

MONITOR=16 # 16 intel - 17 nvidia - 15 wayland
STEP=25 # Step Up/Down brightness by: 25%
FEATURE=10 # Brightness

if [[ "$1" =~ ^[0-9]+$ ]]; then
  NewValue=$1
else
  CurValue=$(ddcutil --bus=$MONITOR -t getvcp $FEATURE)
  if [ $? -ne 0 ];
  then
    CurValue=$(ddcutil --bus=$MONITOR -t getvcp $FEATURE)
  fi

  CurValue="$(echo $CurValue | awk '{print $4}')"
  [[ "$1" == "Up" || "$1" == "+" ]] && NewValue=$(( CurValue + STEP ))
  [[ "$1" == "Down" || "$1" == "-" ]] && NewValue=$(( CurValue - STEP ))
fi

[[ "$NewValue" -lt 10 ]] && NewValue=0      # Negative not allowed
[[ "$NewValue" -gt 100  ]] && NewValue=100  # Can't go over 100

for i in 1 2; do ddcutil --bus=$MONITOR setvcp $FEATURE $NewValue && break; done    # Set new brightness
