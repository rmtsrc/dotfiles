#!/usr/bin/env bash

# `ddcutil capabilities --bus=$MONITOR` to get list of options `D6 05` is monitor power off
ddcutil setvcp D6 05
