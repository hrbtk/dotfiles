#!/bin/bash

# Install software
apps="git 
	micro 
	eza
	bat
	fd-find
	fzf
	afetch
	btop
	neovim
	unzip
	gnome-tweaks
	dconf-editor
	pipx
	alacritty
	afetch"

sudo dnf install -y $apps

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
	com.github.PintaProject.Pinta"

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

# Install VS Code
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo > /dev/null
dnf check-update
sudo dnf install -y code

# Copy config
cp -r ~/dotfiles/.config/alacritty ~/.config/
cp ~/.bashrc ~/.bashrc.bak
cp ~/dotfiles/.bashrc ~/.bashrc