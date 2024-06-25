#!/bin/bash

# Modify dnf.conf
echo "fastestmirror=True 
max_parallel_downloads=10 
deltarpm=true
defaultyes=True
" | sudo tee -a /etc/dnf/dnf.conf

# Enable RPM Fusion
sudo dnf -y install  https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf -y groupupdate core

# Update packages
sudo dnf -y update
sudo dnf -y upgrade --refresh

# Reboot
sudo reboot
