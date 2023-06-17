#!/usr/bin/env bash

# Dell Command Configure
# Install libssl from https://packages.debian.org/en/bullseye/amd64/libssl1.1/download
# https://www.dell.com/support/kbdoc/en-uk/000178000/dell-command-configure

if ! command -v cctk &>/dev/null; then
  echo "cctk could not be found"
  exit 1
fi

read -s -p "BIOS Password: " PASSWORD

sudo env PATH=$PATH cctk --SecureBoot=Enabled --ValSetupPwd=$PASSWORD
sleep 1
reboot
