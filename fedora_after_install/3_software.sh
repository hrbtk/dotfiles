#!/bin/bash

# Install software
apps="git 
	micro 
	eza
	bat
	fd-find
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
	cargo"

sudo dnf -y install $apps

# Install fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all

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
	org.kde.krita"

sudo flatpak install -y flathub $fapps

# Install gnome extensions cli
pipx install gnome-extensions-cli --system-site-packages
pipx ensurepath

# Install Google Chrome
wget -O ~/Downloads/google-chrome-stable_current_x86_64.rpm  https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm
sudo dnf install -y ~/Downloads/google-chrome-stable_current_x86_64.rpm

# Install VS Code
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo > /dev/null
dnf check-update
sudo dnf install -y code

# Copy config
cp -r ~/dotfiles/.config/alacritty ~/.config/
cp ~/.bashrc ~/.bashrc.bak
cp ~/dotfiles/.bashrc ~/.bashrc
