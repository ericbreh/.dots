#! /bin/bash
mkdir ~/.local/share/fonts
mv ./*.ttf ~/.local/share/fonts
fc-cache -f -v
