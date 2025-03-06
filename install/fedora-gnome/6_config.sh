#!/bin/bash

# Copy bash and zsh configs

if [ -f $HOME/.bashrc ]; then
    mv $HOME/.bashrc $HOME/.bashrc.bak
fi
cp $HOME/dotfiles/.bashrc $HOME/.bashrc

if [ -f $HOME/.zshrc ]; then
    mv $HOME/.zshrc $HOME/.zshrc.bak
fi
cp $HOME/dotfiles/.zshrc $HOME/.zshrc
cp -r $HOME/dotfiles/.config/zsh $HOME/.config/zsh
