#!/usr/bin/env bash

# Dell Command Configure
# Install libssl from https://packages.debian.org/en/bullseye/amd64/libssl1.1/download
# https://www.dell.com/support/kbdoc/en-uk/000178000/dell-command-configure

if ! command -v cctk &>/dev/null; then
  echo "cctk could not be found"
  exit 1
fi

cctk="sudo env PATH=$PATH cctk"

$cctk -H --PrimaryBattChargeCfg

printf "\n\nCurrent mode\n"

$cctk --PrimaryBattChargeCfg

if [ -z "$1" ]; then
  printf "\n\n"
  echo "Use ./battery-charge-mode.sh <mode> or \"limit\" to set 50-70% limit"
else
  read -s -p "BIOS Password: " PASSWORD
  printf "\n\n"
  [ "$1" = 'limit' ] && mode="Custom:50-70" || mode="$1"
  $cctk --PrimaryBattChargeCfg=$mode --ValSetupPwd=$PASSWORD
fi
