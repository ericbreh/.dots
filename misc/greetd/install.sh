#!/bin/bash
cp config.toml /etc/greetd/
cp hyprland.conf /etc/greetd/
cp start-hyprland /usr/local/bin/
chmod +x /usr/local/bin/start-hyprland
systemctl enable --now greetd.service