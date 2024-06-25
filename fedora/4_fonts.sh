#!/bin/bash

mkdir -p ~/.local/share/fonts

cd /tmp
wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Meslo.zip
unzip Meslo.zip -d Meslo
cp Meslo/*.ttf ~/.local/share/fonts
rm -rf Meslo.zip Meslo

wget -O iafonts.zip https://github.com/iaolo/iA-Fonts/archive/refs/heads/master.zip
unzip iafonts.zip -d iaFonts
cp iaFonts/iA-Fonts-master/iA\ Writer\ Mono/Static/iAWriterMonoS-*.ttf ~/.local/share/fonts
rm -rf iafonts.zip iaFonts

fc-cache -f -v
cd -