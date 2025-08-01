#!/bin/bash

[ ! -d "$HOME/.local/share/fonts" ] && mkdir -p "$HOME/.local/share/fonts"

DOWNLOADDIR=/tmp

wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Meslo.zip -P $DOWNLOADDIR 
unzip $DOWNLOADDIR/Meslo.zip -d $DOWNLOADDIR/Meslo
cp -r $DOWNLOADDIR/Meslo "$HOME/.local/share/fonts/"
rm -rf $DOWNLOADDIR/Meslo.zip $DOWNLOADDIR/Meslo

wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraCode.zip -P $DOWNLOADDIR
unzip $DOWNLOADDIR/FiraCode.zip -d $DOWNLOADDIR/FiraCode
cp -r $DOWNLOADDIR/FiraCode "$HOME/.local/share/fonts/"
rm -rf $DOWNLOADDIR/FiraCode.zip $DOWNLOADDIR/FiraCode

wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip -P $DOWNLOADDIR
unzip $DOWNLOADDIR/JetBrainsMono.zip -d $DOWNLOADDIR/JetBrainsMono
cp -r $DOWNLOADDIR/JetBrainsMono "$HOME/.local/share/fonts/"
rm -rf $DOWNLOADDIR/JetBrainsMono.zip $DOWNLOADDIR/JetBrainsMono

fc-cache -f -v
