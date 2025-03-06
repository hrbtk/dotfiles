#!/bin/bash

# Update firmware
sudo fwupdmgr get-devices 
sudo fwupdmgr refresh --force 
sudo fwupdmgr get-updates 
sudo fwupdmgr update

# Media codecs
sudo dnf -y groupupdate 'core' 'multimedia' 'sound-and-video' --setopt='install_weak_deps=False' --exclude='PackageKit-gstreamer-plugin' --allowerasing && sync
sudo dnf -y swap 'ffmpeg-free' 'ffmpeg' --allowerasing
sudo dnf -y install gstreamer1-plugins-{bad-\*,good-\*,base} gstreamer1-plugin-openh264 gstreamer1-libav --exclude=gstreamer1-plugins-bad-free-devel ffmpeg gstreamer-ffmpeg
sudo dnf -y install lame\* --exclude=lame-devel
sudo dnf -y group upgrade --with-optional Multimedia

# H/W Video Acceleration
sudo dnf -y install ffmpeg ffmpeg-libs libva libva-utils

# for amd
sudo dnf -y swap mesa-va-drivers mesa-va-drivers-freeworld

#for firefox
sudo dnf -y config-manager --set-enabled fedora-cisco-openh264
sudo dnf -y install openh264 gstreamer1-plugin-openh264 mozilla-openh264
