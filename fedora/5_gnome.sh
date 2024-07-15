#!/bin/bash

# Install gnome extensions
gext install user-theme@gnome-shell-extensions.gcampax.github.com
gext install dash-to-dock@micxgx.gmail.com
gext install clipboard-indicator@tudmotu.com
gext install caffeine@patapon.info
gext install blur-my-shell@aunetx
gext install tilingshell@ferrarodomenico.com
gext install quick-settings-audio-panel@rayzeq.github.io
gext install gsconnect@andyholmes.github.io
gext install Airpod-Battery-Monitor@maniacx.github.com
gext install appindicatorsupport@rgcjonas.gmail.com
gext install Bluetooth-Battery-Meter@maniacx.github.com
gext install emoji-copy@felipeftn
gext install transparent-top-bar@ftpix.com
gext install rounded-window-corners@fxgn
gext install extension-list@tu.berry
gext install fullscreen-avoider@noobsai.github.com
gext install tophat@fflewddur.github.io
# gext install forge@jmmaranan.com

# Load keybindings to dconf
dconf load /org/gnome/desktop/wm/keybindings/ < ~/dotfiles/fedora_after_install/donf_dumps/wmkbdump.dconf
dconf load /org/gnome/shell/keybindings/ < ~/dotfiles/fedora_after_install/donf_dumps/shellkbdump.dconf
dconf load /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ < ~/dotfiles/fedora_after_install/donf_dumps/customkbdump.dconf

# Copy wallpaopers
cp -r ~/dotfiles/wallpapers ~/Pictures/
