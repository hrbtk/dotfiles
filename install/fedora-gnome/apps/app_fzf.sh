#!/bin/bash

# Install fzf
git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf
$HOME/.fzf/install --all --no-fish --no-zsh
