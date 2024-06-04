#!/bin/bash

# Modify dnf.conf
sudo echo "fastestmirror=True 
max_parallel_downloads=10 
deltarpm=true
defaultyes=True
" >> /etc/dnf/dnf.conf

# Enable RPM Fusion
sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf groupupdate core

# Update packages
sudo dnf -y update
sudo dnf -y upgrade --refresh

# Reboot
sudo reboot
