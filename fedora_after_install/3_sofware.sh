#!/bin/bash

# Install software
apps="git 
	micro 
	eza
	bat
	zsh
	fzf
	afetch
	btop
	neovim
	unzip
	gnome-tweaks
	pipx"

sudo dnf install -y $apps

# Setup flathub
sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# Install flatpaks
fapps="net.nokyan.Resources
	com.discordapp.Discord
	com.github.tchx84.Flatseal
	com.mattjakeman.ExtensionManager"

sudo flatpak install -y flathub $fapps

# Install gnome extensions cli
# pipx install gnome-extensions-cli --system-site-packages

# Install gnome extensions
# gext install user-theme@gnome-shell-extensions.gcampax.github.com
# gext install dash-to-dock@micxgx.gmail.com
# gext install clipboard-indicator@tudmotu.com
# gext install caffeine@patapon.info
# gext install blur-my-shell@aunetx

# Install Google Chrome
wget -O ~/Downloads/google-chrome-stable_current_x86_64.rpm  https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm
sudo dnf install -y ~/Downloads/google-chrome-stable_current_x86_64.rpm
