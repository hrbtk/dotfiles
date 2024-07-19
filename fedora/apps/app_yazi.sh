#!/bin/bash

cd /tmp
gh release download --repo sxyazi/yazi --pattern "yazi-x86_64-unknown-linux-musl.zip"
unzip yazi-x86_64-unknown-linux-musl.zip -d yazi
sudo install yazi/yazi /usr/local/bin
rm yazi-x86_64-unknown-linux-musl.zip
rm -rf yazi
cd -