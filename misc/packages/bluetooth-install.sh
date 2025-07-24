#! /bin/bash
pacman -S --needed blueberry bluez bluez-obex bluez-utils
systemctl enable --now bluetooth.service