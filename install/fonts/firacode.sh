#!/bin/bash

[ ! -d "$HOME/.local/share/fonts" ] && mkdir -p "$HOME/.local/share/fonts"

DOWNLOADDIR=/tmp

wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraCode.zip -P $DOWNLOADDIR
unzip $DOWNLOADDIR/FiraCode.zip -d $DOWNLOADDIR/FiraCode
cp -r $DOWNLOADDIR/FiraCode "$HOME/.local/share/fonts/"
rm -rf $DOWNLOADDIR/FiraCode.zip $DOWNLOADDIR/FiraCode

fc-cache -f -v
