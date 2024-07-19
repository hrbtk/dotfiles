#!/bin/bash

# Copy bash and zsh configs

if [ -f ~/.bashrc ]; then
    mv ~/.bashrc ~/.bashrc.bak
fi
cp ~/dotfiles/.bashrc ~/.bashrc

if [ -f ~/.zshrc ]; then
    mv ~/.zshrc ~/.zshrc.bak
fi
cp ~/dotfiles/.zshrc ~/.zshrc
cp -r ~/dotfiles/.config/zsh ~/.config/zsh