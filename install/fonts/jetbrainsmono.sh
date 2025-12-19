#!/bin/bash

[ ! -d "$HOME/.local/share/fonts" ] && mkdir -p "$HOME/.local/share/fonts"

DOWNLOADDIR=/tmp

wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip -P $DOWNLOADDIR
unzip $DOWNLOADDIR/JetBrainsMono.zip -d $DOWNLOADDIR/JetBrainsMono
cp -r $DOWNLOADDIR/JetBrainsMono "$HOME/.local/share/fonts/"
rm -rf $DOWNLOADDIR/JetBrainsMono.zip $DOWNLOADDIR/JetBrainsMono

fc-cache -f -v
