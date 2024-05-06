#!/bin/bash

# Change shell to zsh
sudo chsh -s $(which zsh)

# Copy config files
cp ~/dotfiles/.zshrc ~/.zshrc
cp -r ~/dotfiles/.config/zsh ~/.config/zsh
