#!/bin/bash

mkdir -p ~/.local/share/fonts

cd /tmp
wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Meslo.zip
unzip Meslo.zip -d Meslo
cp Meslo/*.ttf ~/.local/share/fonts
rm -rf Meslo.zip Meslo

wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraCode.zip
unzip FiraCode.zip -d FiraCode
cp FiraCode/*.ttf ~/.local/share/fonts
rm -rf FiraCode.zip FiraCode

fc-cache -f -v
cd -
