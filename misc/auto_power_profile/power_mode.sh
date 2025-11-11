#!/usr/bin/env bash

if [[ "$(cat /sys/class/power_supply/AC/online)" == "1" ]]; then
  sudo tuned-adm profile balanced
else
  sudo tuned-adm profile powersave
fi