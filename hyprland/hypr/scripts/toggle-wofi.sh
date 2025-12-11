#!/usr/bin/env bash

if pgrep -f "^wofi" >/dev/null; then
    pkill -f "wofi"
else
    bash -c "$*"
fi
