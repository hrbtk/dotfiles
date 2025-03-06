#!/bin/bash

mkdir -p $HOME/.local/share/fonts

cd /tmp
wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Meslo.zip
unzip Meslo.zip -d Meslo
cp Meslo/*.ttf $HOME/.local/share/fonts
rm -rf Meslo.zip Meslo

wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraCode.zip
unzip FiraCode.zip -d FiraCode
cp FiraCode/*.ttf $HOME/.local/share/fonts
rm -rf FiraCode.zip FiraCode

wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip
unzip JetBrainsMono.zip -d JetBrainsMono
cp JetBrainsMono.zip /*.ttf $HOME/.local/share/fonts
rm -rf JetBrainsMono.zip JetBrainsMono

fc-cache -f -v
cd -
