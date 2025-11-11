#!/usr/bin/env bash
mkdir ~/.local/share/fonts
cp ./*.ttf ~/.local/share/fonts
cp ./*.otf ~/.local/share/fonts
fc-cache -f -v
