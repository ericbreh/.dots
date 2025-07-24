#!/bin/bash

if [[ "$(cat /sys/class/power_supply/AC/online)" == "1" ]]; then
  powerprofilesctl set performance
else
  powerprofilesctl set power-saver
fi
