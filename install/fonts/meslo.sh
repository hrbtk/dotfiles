#!/bin/bash

[ ! -d "$HOME/.local/share/fonts" ] && mkdir -p "$HOME/.local/share/fonts"

DOWNLOADDIR=/tmp

wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Meslo.zip -P $DOWNLOADDIR
unzip $DOWNLOADDIR/Meslo.zip -d $DOWNLOADDIR/Meslo
cp -r $DOWNLOADDIR/Meslo "$HOME/.local/share/fonts/"
rm -rf $DOWNLOADDIR/Meslo.zip $DOWNLOADDIR/Meslo

fc-cache -f -v
