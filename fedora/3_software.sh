#!/bin/bash

# Install software
apps="git 
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
	neovim
	unzip
	gnome-tweaks
	dconf-editor
	pipx
	alacritty
	afetch
	cargo
	adw-gtk3-theme"

sudo dnf -y install $apps

# Setup flathub
sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# Install flatpaks
fapps="net.nokyan.Resources
	com.discordapp.Discord
	com.github.tchx84.Flatseal
	com.mattjakeman.ExtensionManager
	com.heroicgameslauncher.hgl
	com.usebottles.bottles
	org.gnome.World.PikaBackup
	com.github.PintaProject.Pinta
	io.github.amit9838.mousam
	io.gitlab.adhami3310.Converter
	org.kde.krita
	com.raggesilver.BlackBox
	org.gtk.Gtk3theme.adw-gtk3 
	org.gtk.Gtk3theme.adw-gtk3-dark"

sudo flatpak install -y flathub $fapps

# Install gnome extensions cli
pipx install gnome-extensions-cli --system-site-packages
pipx ensurepath

# Copy config
cp -r ~/dotfiles/.config/alacritty ~/.config/
cp ~/.bashrc ~/.bashrc.bak
cp ~/dotfiles/.bashrc ~/.bashrc
