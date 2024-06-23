#!/bin/bash

# Install gnome extensions
gext install user-theme@gnome-shell-extensions.gcampax.github.com
gext install dash-to-dock@micxgx.gmail.com
gext install clipboard-indicator@tudmotu.com
gext install caffeine@patapon.info
gext install blur-my-shell@aunetx

# Load keybindings to dconf
dconf load /org/gnome/desktop/wm/keybindings/ < ~/dotfiles/fedora_after_install/donf_dumps/wmkbdump.dconf
dconf load /org/gnome/shell/keybindings/ < ~/dotfiles/fedora_after_install/donf_dumps/shellkbdump.dconf
dconf load /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ < ~/dotfiles/fedora_after_install/donf_dumps/customkbdump.dconf

# Copy wallpaopers
cp -r ~/dotfiles/wallpapers ~/Pictures/

# Download Meslo Nerd Font
wget -O ~/Downloads/Meslo.tar.xz https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/Meslo.tar.xz
tar -xf ~/Downloads/Meslo.tar.xz
mkdir -p ~/.local/share/fonts/Meslo
mv ~/Downloads/Meslo*.ttf ~/.local/share/fonts/Meslo/
fc-cache -f -v
