#!/bin/bash

cd /tmp
gh release download --repo sxyazi/yazi --pattern "yazi-x86_64-unknown-linux-musl.zip"
unzip yazi-x86_64-unknown-linux-musl.zip -d yazi
sudo install yazi/yazi /usr/local/bin
rm yazi-x86_64-unknown-linux-musl.zip
rm -rf yazi
echo 'function yy() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}' > ~/.bashrc
cd -