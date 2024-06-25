#!/bin/bash

cd /tmp
wget https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm
sudo dnf install -y ./google-chrome-stable_current_x86_64.rpm
sudo rm ./google-chrome-stable_current_x86_64.rpm
cd -