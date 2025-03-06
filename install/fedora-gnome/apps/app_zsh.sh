#!/bin/bash

# Install zsh
sudo dnf -y install zsh

# Change shell to zsh
chsh -s $(which zsh)
