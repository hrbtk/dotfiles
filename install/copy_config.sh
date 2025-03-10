#!/bin/bash

# Copy bash and zsh configs

if [ -f "$HOME/.bashrc" ]; then
    mv "$HOME/.bashrc" "$HOME/.bashrc.bak"
fi
cp "$HOME/dotfiles/.bashrc" "$HOME/.bashrc"

if [ -f "$HOME/.zshrc"]; then
    mv "$HOME/.zshrc" "$HOME/.zshrc.bak"
fi
cp "$HOME/dotfiles/.zshrc" "$HOME/.zshrc"

# bat
if [[ -x "$(command -v bat)" ]]; then
    cp -r "$HOME/dotfiles/.config/bat" "$HOME/.config"
fi

# ghostty
if [[ -x "$(command -v ghostty)" ]]; then
    cp -r "$HOME/dotfiles/.config/ghostty" "$HOME/.config"
fi

# yazi
if [[ -x "$(command -v yazi)" ]]; then
    cp -r "$HOME/dotfiles/.config/yazi" "$HOME/.config"
fi

# starship
if [[ -x "$(command -v starship)" ]]; then
    cp -r "$HOME/dotfiles/.config/starship" "$HOME/.config"
fi

# helix
if [[ -x "$(command -v helix)" ]] || [[ -x "$(command -v hx)" ]];  then
    cp -r "$HOME/dotfiles/.config/helix" "$HOME/.config"
fi

# kitty
if [[ -x "$(command -v kitty)" ]]; then
    cp -r "$HOME/dotfiles/.config/kitty" "$HOME/.config"
fi

# zed
if [[ -x "$(command -v zed)" ]]; then
    cp -r "$HOME/dotfiles/.config/zed" "$HOME/.config"
fi
