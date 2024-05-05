#!/bin/bash

# Update firmware
sudo fwupdmgr get-devices 
sudo fwupdmgr refresh --force 
sudo fwupdmgr get-updates 
sudo fwupdmgr update

# Media codecs
sudo dnf groupupdate 'core' 'multimedia' 'sound-and-video' --setopt='install_weak_deps=False' --exclude='PackageKit-gstreamer-plugin' --allowerasing && sync
sudo dnf swap 'ffmpeg-free' 'ffmpeg' --allowerasing
sudo dnf install -y gstreamer1-plugins-{bad-\*,good-\*,base} gstreamer1-plugin-openh264 gstreamer1-libav --exclude=gstreamer1-plugins-bad-free-devel ffmpeg gstreamer-ffmpeg
sudo dnf install -y lame\* --exclude=lame-devel
sudo dnf group upgrade --with-optional Multimedia

# H/W Video Acceleration
sudo dnf install -y ffmpeg ffmpeg-libs libva libva-utils

# for amd
# sudo dnf swap mesa-va-drivers mesa-va-drivers-freeworld

#for firefox
sudo dnf config-manager --set-enabled fedora-cisco-openh264
sudo dnf install -y openh264 gstreamer1-plugin-openh264 mozilla-openh264

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
pipx install gnome-extensions-cli --system-site-packages

# Install gnome extensions
gext install user-theme@gnome-shell-extensions.gcampax.github.com
gext install dash-to-dock@micxgx.gmail.com
gext install clipboard-indicator@tudmotu.com
gext install caffeine@patapon.info
gext install blur-my-shell@aunetx

# Install Google Chrome
wget -O ~/Downloads/google-chrome-stable_current_x86_64.rpm  https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm
sudo dnf install -y ~/Downloads/google-chrome-stable_current_x86_64.rpm

# Change shell to zsh
sudo chsh -s $(which zsh)

# Copy config files
cp ~/dotfiles/.zshrc ~/.zshrc
cp -r ~/dotfiles/.config/zsh ~/.config/zsh
