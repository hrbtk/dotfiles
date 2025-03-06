#!/bin/bash

set -e
# Install software
apps="git 
	fzf
	micro 
	eza
	bat
	fd-find
	sd
	jq
	gh
	ripgrep
	afetch
	btop
	helix
	unzip
	gnome-tweaks
	dconf-editor
	pipx
	ghostty
	cargo
	adw-gtk3-theme"

sudo dnf -y install $apps
