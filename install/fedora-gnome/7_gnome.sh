#!/bin/bash

# Install gnome extensions cli
pipx install gnome-extensions-cli --system-site-packages
pipx ensurepath

# Install gnome extensions
gext install Airpod-Battery-Monitor@maniacx.github.com
gext install appindicatorsupport@rgcjonas.gmail.com
gext install Bluetooth-Battery-Meter@maniacx.github.com
gext install blur-my-shell@aunetx
gext install caffeine@patapon.info
gext install clipboard-indicator@tudmotu.com
gext install dash-to-dock@micxgx.gmail.com
gext install display-brightness-ddcutil@themightydeity.github.com
gext install emoji-copy@felipeftn
gext install gnome-fuzzy-app-search@gnome-shell-extensions.Czarlie.gitlab.com
gext install gsconnect@andyholmes.github.io
gext install media-progress@krypion17
gext install privacy-indicators-accent-color@sopht.li
gext install rounded-window-corners@fxgn
gext install status-area-horizontal-spacing@mathematical.coffee.gmail.com
gext install tilingshell@ferrarodomenico.com
gext install user-theme@gnome-shell-extensions.gcampax.github.com

# Load keybindings to dconf
dconf load /org/gnome/desktop/wm/keybindings/ < $HOME/fedora-gnome-workstation-install/donf_dumps/wmkbdump.dconf
dconf load /org/gnome/shell/keybindings/ < $HOME/fedora-gnome-workstation-install/donf_dumps/shellkbdump.dconf
dconf load /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ < $HOME/fedora-gnome-workstation-install/donf_dumps/customkbdump.dconf

# Copy wallpaopers
cp -r $HOME/dotfiles/wallpapers $HOME/Pictures/
