#!/usr/bin/env bash

read -s -p "BIOS Password: " PASSWORD

sudo cctk --SecureBoot=Enabled --ValSetupPwd=$PASSWORD
sleep 1
reboot
