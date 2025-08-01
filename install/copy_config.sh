#!/bin/bash

copy_config() {
	# Copy bash and zsh configs
	if [ -f "$HOME/.bashrc" ]; then
		mv "$HOME/.bashrc" "$HOME/.bashrc.bak"
	fi
	cp "$DEVDIR/dotfiles/.bashrc" "$HOME/.bashrc"

	if [ -f "$HOME/.zshrc" ]; then
		mv "$HOME/.zshrc" "$HOME/.zshrc.bak"
	fi
	cp "$DEVDIR/dotfiles/.zshrc" "$HOME/.zshrc"

	# bat
	if [[ -x "$(command -v bat)" ]]; then
		cp -r "$DEVDIR/dotfiles/.config/bat" "$HOME/.config"
	fi

	# ghostty
	if [[ -x "$(command -v ghostty)" ]]; then
		cp -r "$DEVDIR/dotfiles/.config/ghostty" "$HOME/.config"
	fi

	# yazi
	if [[ -x "$(command -v yazi)" ]]; then
		cp -r "$DEVDIR/dotfiles/.config/yazi" "$HOME/.config"
	fi

	# starship
	if [[ -x "$(command -v starship)" ]]; then
		cp -r "$DEVDIR/dotfiles/.config/starship" "$HOME/.config"
	fi

	# helix
	if [[ -x "$(command -v helix)" ]] || [[ -x "$(command -v hx)" ]];  then
		cp -r "$DEVDIR/dotfiles/.config/helix" "$HOME/.config"
	fi

	# kitty
	if [[ -x "$(command -v kitty)" ]]; then
		cp -r "$DEVDIR/dotfiles/.config/kitty" "$HOME/.config"
	fi

	# zed
	if [[ -x "$(command -v zed)" ]]; then
		cp -r "$DEVDIR/dotfiles/.config/zed" "$HOME/.config"
	fi
}


if [[ -n $DEVDIR ]]; then
	echo "DEVDIR variable exist"
	copy_config
else
	echo "DEVDIR variable doesn't exist"
fi

