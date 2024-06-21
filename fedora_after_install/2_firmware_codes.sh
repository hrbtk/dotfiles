#!/bin/bash

# Update firmware
sudo fwupdmgr get-devices 
sudo fwupdmgr refresh --force 
sudo fwupdmgr get-updates 
sudo fwupdmgr update

# Media codecs
sudo dnf groupupdate -y 'core' 'multimedia' 'sound-and-video' --setopt='install_weak_deps=False' --exclude='PackageKit-gstreamer-plugin' --allowerasing && sync
sudo dnf swap -y 'ffmpeg-free' 'ffmpeg' --allowerasing
sudo dnf install -y gstreamer1-plugins-{bad-\*,good-\*,base} gstreamer1-plugin-openh264 gstreamer1-libav --exclude=gstreamer1-plugins-bad-free-devel ffmpeg gstreamer-ffmpeg
sudo dnf install -y lame\* --exclude=lame-devel
sudo dnf group upgrade -y --with-optional Multimedia

# H/W Video Acceleration
sudo dnf install -y ffmpeg ffmpeg-libs libva libva-utils

# for amd
sudo dnf -y swap mesa-va-drivers mesa-va-drivers-freeworld

#for firefox
sudo dnf config-manager --set-enabled fedora-cisco-openh264
sudo dnf install -y openh264 gstreamer1-plugin-openh264 mozilla-openh264
