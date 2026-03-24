#!/usr/bin/env bash

date=$(date +"%Y-%m-%d")
echo -n $date | wl-copy

notify-send "Copy Date" "Copied todays date: $date " -i dialog-information || true