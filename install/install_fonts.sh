#!/bin/bash

[ ! -d "$HOME/.local/share/fonts" ] && mkdir -p "$HOME/.local/share/fonts"

cd /tmp
wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Meslo.zip
unzip Meslo.zip -d Meslo
cp -r Meslo "$HOME/.local/share/fonts/"
rm -rf Meslo.zip Meslo

wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraCode.zip
unzip FiraCode.zip -d FiraCode
cp -r FiraCode "$HOME/.local/share/fonts/"
rm -rf FiraCode.zip FiraCode

wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip
unzip JetBrainsMono.zip -d JetBrainsMono
cp -r JetBrainsMono "$HOME/.local/share/fonts/"
rm -rf JetBrainsMono.zip JetBrainsMono

fc-cache -f -v
cd -
