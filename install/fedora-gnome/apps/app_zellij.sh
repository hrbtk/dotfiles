#!/bin/bash

cd /tmp
gh release download --repo zellij-org/zellij --pattern "zellij-x86_64-unknown-linux-musl.tar.gz"
tar -xf zellij-x86_64-unknown-linux-musl.tar.gz zellij
sudo install zellij /usr/local/bin
rm zellij-x86_64-unknown-linux-musl.tar.gz zellij
cd -