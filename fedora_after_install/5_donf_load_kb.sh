#!/bin/bash

dconf load /org/gnome/desktop/wm/keybindings/ < ./dconf_dumps/wmkbdump.dconf
dconf load /org/gnome/shell/keybindings/ < ./dconf_dumps/shellkbdump.dconf
