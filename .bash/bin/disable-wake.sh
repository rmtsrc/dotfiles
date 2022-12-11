#!/usr/bin/env bash

# Disable system from waking up on activity from certain devices
# 1. Use: `grep enabled cat /proc/acpi/wakeup` to list devices that can wake the system
# 2. Use `lspci` to list device names and compare the device ID devices that can wake
# 3. Add the wakeup code in `toDisable`

# My case:
# XHCI = USB controller: Intel USB 3.2 Gen 2x1 xHCI Host Controller
# TXHC = USB controller: Intel Thunderbolt 4 USB Controller
# TDM1 = USB controller: Intel Thunderbolt 4 NHI #1

toDisable="XHCI TXHC TDM1 TRP2 TRP3"

for i in $toDisable; do
  if [[ $(cat /proc/acpi/wakeup | grep $i | awk '{print substr($3,2); }') == enabled ]]; then
    echo $i | tee /proc/acpi/wakeup
  fi
done
