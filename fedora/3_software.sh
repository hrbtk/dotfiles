#!/bin/bash
set -e
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
	dev.vencord.Vesktop
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
	org.gtk.Gtk3theme.adw-gtk3-dark
	io.github.realmazharhussain.GdmSettings"

sudo flatpak install -y flathub $fapps

# Install gnome extensions cli
pipx install gnome-extensions-cli --system-site-packages
pipx ensurepath

# Install apps with scripts
for file in ~/dotfiles/fedora/apps/app_*.sh; do
    bash "$file"
done
