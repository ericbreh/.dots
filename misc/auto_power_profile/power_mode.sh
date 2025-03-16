#!/bin/bash

if [[ "$(cat /sys/class/power_supply/AC/online)" == "1" ]]; then
  /usr/sbin/tuned-adm profile throughput-performance
else
  /usr/sbin/tuned-adm profile powersave
fi
