#!/bin/bash

# Install gnome extensions
gext install user-theme@gnome-shell-extensions.gcampax.github.com
gext install dash-to-dock@micxgx.gmail.com
gext install clipboard-indicator@tudmotu.com
gext install caffeine@patapon.info
gext install blur-my-shell@aunetx

# Load keybindings to dconf
dconf load /org/gnome/desktop/wm/keybindings/ < ./dconf_dumps/wmkbdump.dconf
dconf load /org/gnome/shell/keybindings/ < ./dconf_dumps/shellkbdump.dconf

# Copy wallpaopers
cp ~/dotfiles/wallpapers ~/Pictures/
