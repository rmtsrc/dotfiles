#!/usr/bin/env bash

# Stop on error
set -e

Monitors=$( xrandr --verbose --current ) # Get monitors


MONITOR=$( echo "$Monitors" | grep " connected" | grep "primary" | awk '{print $1}' ) # Auto discover monitor name or use to hard code: xrandr | grep " connected"
STEP=5 # Step Up/Down brightnes by: 5 = ".05", 10 = ".10", etc.

CurrBright=$( echo "$Monitors" | grep ^"$MONITOR" -A5 | tail -n1 )
CurrBright="${CurrBright##* }"  # Get brightness level with decimal place

[[ $CurrBright == 0.0* ]] && CurrBright=${CurrBright::-1}

Left=${CurrBright%%"."*}        # Extract left of decimal point
Right=${CurrBright#*"."}        # Extract right of decimal point

MathBright="0"
[[ "$Left" != 0 && "$STEP" -lt 10 ]] && STEP=10     # > 1.0, only .1 works
[[ "$Left" != 0 ]] && MathBright="$Left"00          # 1.0 becomes "100"
[[ "${#Right}" -eq 1 ]] && Right="$Right"0          # 0.5 becomes "50"
MathBright=$(( MathBright + Right ))


[[ "$1" == "Up" || "$1" == "+" ]] && MathBright=$(( MathBright + STEP ))
[[ "$1" == "Down" || "$1" == "-" ]] && MathBright=$(( MathBright - STEP ))
[[ "$MathBright" -lt 5 ]] && MathBright=0    # Negative not allowed
[[ "$MathBright" -gt 100  ]] && MathBright=100      # Can't go over 1.00

if [[ "${#MathBright}" -eq 3 ]] ; then
    MathBright="$MathBright"000         # Pad with lots of zeros
    CurrBright="${MathBright:0:1}.${MathBright:1:2}"
elif [[ "$MathBright" -lt 10 ]] ; then
    MathBright=0"$MathBright"0         # Pad with lots of zeros
    CurrBright=".${MathBright:0:2}"
else
    MathBright="$MathBright"000         # Pad with lots of zeros
    CurrBright=".${MathBright:0:2}"
fi

xrandr --output "$MONITOR" --brightness "$CurrBright"   # Set new brightness

# Display current brightness
if [[ "$DEBUG" == "true" ]] ; then
  printf "Monitor $MONITOR "
  echo $( xrandr --verbose --current | grep ^"$MONITOR" -A5 | tail -n1 )
fi
