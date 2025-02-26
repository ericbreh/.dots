#!/bin/zsh

if pgrep -x "wlogout" > /dev/null; then
    pkill -x "wlogout"
else
    wlogout -b 5
fi

