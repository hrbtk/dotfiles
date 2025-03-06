#!/bin/bash

# install starship prompt
sudo dnf -y copr enable atim/starship
sudo dnf -y install starship

# add prompt to bashrc file
echo '
# add starship prompt
eval "$(starship init bash)"
' | sudo tee -a $HOME/.bashrc



