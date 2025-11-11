#!/usr/bin/env bash
set -e

PROFILE_DIR=$(find "$HOME/.zen" -maxdepth 1 -type d -name "*.default*" | head -n 1)
cp zen-keyboard-shortcuts.json "$PROFILE_DIR/"
