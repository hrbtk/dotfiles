#!/bin/bash

# Select package manager
if [[ -x "$(command -v dnf)" ]]; then
  echo "Fedora"
  INSTALLCOMM=$(sudo dnf install -y)
elif [[ -x "$(command -v apt)" ]]; then
  echo "Ubuntu"
  INSTALLCOMM=$(sudo apt install -y)
elif [[ -x "$(command -v yay)" ]]; then
  echo "Arch Yay"
  INSTALLCOMM=$(yay -S --noconfirm)
elif [[ -x "$(command -v pacman)" ]]; then
  echo "Arch Pacman"
  INSTALLCOMM=$(sudo pacman -S --noconfirm)
else
  echo "Unsupported"
fi

# List of packages
PACKAGES="git 
	fzf
	micro 
	eza
	bat
	fd-find
	sd
	jq
	gh
	ripgrep
	btop
	helix
	neovim
	unzip
	ghostty
	cargo"

# Install packages
echo "$INSTALLCOMM $PACKAGES"
