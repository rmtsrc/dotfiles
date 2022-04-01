#!/usr/bin/env bash

if ! command -v cctk &> /dev/null
then
    echo "cctk could not be found"
    exit 1
fi

read -s -p "BIOS Password: " PASSWORD

sudo env PATH=$PATH cctk --SecureBoot=Enabled --ValSetupPwd=$PASSWORD
sleep 1
reboot
