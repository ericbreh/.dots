#!/bin/bash
cp config.toml /etc/greetd/
cp hyprland.conf /etc/greetd/
cp start-hyprland /usr/local/bin/
systemctl enable --now greetd.service