# Update firmware
sudo fwupdmgr get-devices 
sudo fwupdmgr refresh --force 
sudo fwupdmgr get-updates 
sudo fwupdmgr update

# Media codecs
sudo dnf groupupdate 'core' 'multimedia' 'sound-and-video' --setopt='install_weak_deps=False' --exclude='PackageKit-gstreamer-plugin' --allowerasing && sync
sudo dnf swap 'ffmpeg-free' 'ffmpeg' --allowerasing
sudo dnf install gstreamer1-plugins-{bad-\*,good-\*,base} gstreamer1-plugin-openh264 gstreamer1-libav --exclude=gstreamer1-plugins-bad-free-devel ffmpeg gstreamer-ffmpeg
sudo dnf install lame\* --exclude=lame-devel
sudo dnf group upgrade --with-optional Multimedia

# H/W Video Acceleration
sudo dnf install ffmpeg ffmpeg-libs libva libva-utils

# for amd
sudo dnf swap mesa-va-drivers mesa-va-drivers-freeworld

#for firefox
sudo dnf config-manager --set-enabled fedora-cisco-openh264
sudo dnf install -y openh264 gstreamer1-plugin-openh264 mozilla-openh264

# Install software
apps = [
			"git", 
			"micro", 
			"eza",
			"bat",
			"zsh",
			"fzf",
			"afetch",
			"btop",
			"neovim",
			"unzip",
			"google-chrome-stable",
			"gnome-tweaks"				
]
sudo dnf install -y "${apps[@]}"

# Setup flathub
sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# Install flatpaks
fapps = [
			"net.nokyan.Resources",
			"com.discordapp.Discord",
			"com.github.tchx84.Flatseal",
			"com.mattjakeman.ExtensionManager"
]
sudo flatpak install -y flathub "${fapps[@]}"
