#!/usr/bin/env bash
cp config.toml /etc/greetd/
cp start-hyprland /usr/local/bin/
chmod +x /usr/local/bin/start-hyprland
cp pam.d-greetd.txt /etc/pam.d/greetd
systemctl enable --now greetd.service
