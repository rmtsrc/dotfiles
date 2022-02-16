#!/usr/bin/env bash

# Picture in picture control for Dell S2721QS monitor

# ddcutil capabilities
#
#  Feature: E2 (Manufacturer specific feature)
#     Values: 00 1D 02 20 21 22 0E 12 14 23 24 27 (interpretation unavailable)
#  Feature: E9 (Manufacturer specific feature)
#     Values: 00 01 02 21 22 24 (interpretation unavailable)
#  Feature: F0 (Manufacturer specific feature)
#     Values: 00 0C 0F 10 11 31 32 34 35 (interpretation unavailable)

# ddcutil setvcp --noverify 0xE9 0x00 # PiP off
# ddcutil setvcp --noverify 0xE9 0x21 # PiP small
# ddcutil setvcp --noverify 0xE9 0x22 # PiP large
# ddcutil setvcp --noverify 0xE9 0x02 # PiP move
# ddcutil setvcp --noverify 0xE9 0x24 # PiP side by side

[[ "$1" == "off" ]] && ddcutil setvcp --noverify 0xE9 0x00 # PiP off
[[ "$1" == "small" ]] && ddcutil setvcp --noverify 0xE9 0x21 # PiP small
[[ "$1" == "large" ]] && ddcutil setvcp --noverify 0xE9 0x22 # PiP large
[[ "$1" == "move" ]] && ddcutil setvcp --noverify 0xE9 0x02 # PiP move
[[ "$1" == "vertical" ]] && ddcutil setvcp --noverify 0xE9 0x24 # PiP side by side
