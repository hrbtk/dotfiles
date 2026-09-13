#!/bin/bash
# "Things To Do!" script for a fresh Fedora Workstation installation



# Check if the script is run with sudo
if [ "$EUID" -ne 0 ]; then
    echo "Please run this script with sudo"
    exit 1
fi

# Funtion to echo colored text
color_echo() {
    local color="$1"
    local text="$2"
    case "$color" in
        "red")     echo -e "\033[0;31m$text\033[0m" ;;
        "green")   echo -e "\033[0;32m$text\033[0m" ;;
        "yellow")  echo -e "\033[1;33m$text\033[0m" ;;
        "blue")    echo -e "\033[0;34m$text\033[0m" ;;
        *)         echo "$text" ;;
    esac
}

# Set variables
ACTUAL_USER=$SUDO_USER
ACTUAL_HOME=$(eval echo ~$SUDO_USER)
LOG_FILE="/var/log/fedora_things_to_do.log"
INITIAL_DIR=$(pwd)

# Function to generate timestamps
get_timestamp() {
    date +"%Y-%m-%d %H:%M:%S"
}

# Function to log messages
log_message() {
    local message="$1"
    echo "$(get_timestamp) - $message" | tee -a "$LOG_FILE"
}

# Function to handle errors
handle_error() {
    local exit_code=$?
    local message="$1"
    if [ $exit_code -ne 0 ]; then
        color_echo "red" "ERROR: $message"
        exit $exit_code
    fi
}

# Function to prompt for reboot
prompt_reboot() {
    sudo -u $ACTUAL_USER bash -c 'read -p "It is time to reboot the machine. Would you like to do it now? (y/n): " choice; [[ $choice == [yY] ]]'
    if [ $? -eq 0 ]; then
        color_echo "green" "Rebooting..."
        reboot
    else
        color_echo "red" "Reboot canceled."
    fi
}

# Function to backup configuration files
backup_file() {
    local file="$1"
    if [ -f "$file" ]; then
        cp "$file" "$file.bak"
        handle_error "Failed to backup $file"
        color_echo "green" "Backed up $file"
    fi
}

install_from_flathub() {
    local program_name="$1"
    local package_name="$2"
    color_echo "yellow" "Installing $program_name..."
    flatpak install -y flathub $2
    color_echo "green" "$program_name installed successfully."
}

echo "";
echo "╔═════════════════════════════════════════════════════════════════════════════╗";
echo "║                                                                             ║";
echo "║   ░█▀▀░█▀▀░█▀▄░█▀█░█▀▄░█▀█░░░█░█░█▀█░█▀▄░█░█░█▀▀░▀█▀░█▀█░▀█▀░▀█▀░█▀█░█▀█░   ║";
echo "║   ░█▀▀░█▀▀░█░█░█░█░█▀▄░█▀█░░░█▄█░█░█░█▀▄░█▀▄░▀▀█░░█░░█▀█░░█░░░█░░█░█░█░█░   ║";
echo "║   ░▀░░░▀▀▀░▀▀░░▀▀▀░▀░▀░▀░▀░░░▀░▀░▀▀▀░▀░▀░▀░▀░▀▀▀░░▀░░▀░▀░░▀░░▀▀▀░▀▀▀░▀░▀░   ║";
echo "║   ░░░░░░░░░░░░▀█▀░█░█░▀█▀░█▀█░█▀▀░█▀▀░░░▀█▀░█▀█░░░█▀▄░█▀█░█░░░░░░░░░░░░░░   ║";
echo "║   ░░░░░░░░░░░░░█░░█▀█░░█░░█░█░█░█░▀▀█░░░░█░░█░█░░░█░█░█░█░▀░░░░░░░░░░░░░░   ║";
echo "║   ░░░░░░░░░░░░░▀░░▀░▀░▀▀▀░▀░▀░▀▀▀░▀▀▀░░░░▀░░▀▀▀░░░▀▀░░▀▀▀░▀░░░░░░░░░░░░░░   ║";
echo "║                                                                             ║";
echo "╚═════════════════════════════════════════════════════════════════════════════╝";
echo "";
echo "This script automates \"Things To Do!\" steps after a fresh Fedora Workstation installation"
echo "ver. 25.08 / 100 Stars Edition"
echo ""
echo "Don't run this script if you didn't build it yourself or don't know what it does."
echo ""
read -p "Press Enter to continue or CTRL+C to cancel..."

# System Upgrade
color_echo "blue" "Performing system upgrade... This may take a while..."
dnf upgrade -y


# System Configuration
# Set the system hostname to uniquely identify the machine on the network
color_echo "yellow" "Setting hostname..."
hostnamectl set-hostname fedora pc

# Optimize DNF package manager for faster downloads and efficient updates
color_echo "yellow" "Configuring DNF Package Manager..."
backup_file "/etc/dnf/dnf.conf"
dnf -y install dnf-plugins-core
# Max Parallel Downloads
echo "max_parallel_downloads=10" | tee -a /etc/dnf/dnf.conf > /dev/null
# Select Fastest Mirror
echo "fastestmirror=True" | tee -a /etc/dnf/dnf.conf > /dev/null
# Default Yes
echo "defaultyes=True" | tee -a /etc/dnf/dnf.conf > /dev/null

# Replace Fedora Flatpak Repo with Flathub for better package management and apps stability
color_echo "yellow" "Replacing Fedora Flatpak Repo with Flathub..."
dnf install -y flatpak
flatpak remote-delete fedora --force || true
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
sudo flatpak repair
flatpak update

# Install and enable SSH server for secure remote access and file transfers
color_echo "yellow" "Installing and enabling SSH..."
dnf install -y openssh-server
systemctl enable --now sshd

# Check and apply firmware updates to improve hardware compatibility and performance
color_echo "yellow" "Checking for firmware updates..."
fwupdmgr refresh --force
fwupdmgr get-updates
fwupdmgr update -y

# Enable RPM Fusion repositories to access additional software packages and codecs
color_echo "yellow" "Enabling RPM Fusion repositories..."
dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
dnf install -y https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
dnf update @core -y

# Install multimedia codecs to enhance multimedia capabilities
color_echo "yellow" "Installing multimedia codecs..."
dnf swap ffmpeg-free ffmpeg --allowerasing -y
dnf update @multimedia --setopt="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin -y
dnf update @sound-and-video -y

# Install Hardware Accelerated Codecs for AMD GPUs. This improves video playback and encoding performance on systems with AMD graphics.
color_echo "yellow" "Installing AMD Hardware Accelerated Codecs..."
dnf swap mesa-va-drivers mesa-va-drivers-freeworld -y
dnf swap mesa-vdpau-drivers mesa-vdpau-drivers-freeworld -y

# Configure power settings to prevent system sleep and hibernation
color_echo "yellow" "Configuring power settings..."
sudo -u $ACTUAL_USER gsettings set org.gnome.desktop.session idle-delay 0
sudo -u $ACTUAL_USER gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type 'nothing'
sudo -u $ACTUAL_USER gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type 'nothing'
sudo -u $ACTUAL_USER gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-timeout 0
sudo -u $ACTUAL_USER gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-timeout 0
sudo -u $ACTUAL_USER gsettings set org.gnome.settings-daemon.plugins.power power-button-action 'suspend'


# App Installation
# Install essential applications
color_echo "yellow" "Installing essential applications..."
dnf install -y btop htop fastfetch unzip unrar git wget curl gnome-tweaks fzf eza bat fd-find jq gh ripgrep dconf-editor neovim zsh
dnf copr enable lihaohong/yazi -y
dnf install -y yazi --setopt=install_weak_deps=False
dnf copr enable scottames/ghostty -y
dnf install -y ghostty
color_echo "green" "Essential applications installed successfully."

# Install Starship prompt
curl -sS https://starship.rs/install.sh | sh

# Install Internet & Communication applications
color_echo "yellow" "Installing Google Chrome..."
if command -v dnf4 &>/dev/null; then
  dnf4 config-manager --set-enabled google-chrome
else
  dnf config-manager setopt google-chrome.enabled=1
fi
dnf install -y google-chrome-stable
color_echo "green" "Google Chrome installed successfully."
color_echo "yellow" "Installing Zen Browser..."
flatpak install -y flathub app.zen_browser.zen
color_echo "green" "Zen Browser installed successfully."
color_echo "yellow" "Installing Discord..."
flatpak install -y flathub com.discordapp.Discord
color_echo "green" "Discord installed successfully."
color_echo "yellow" "Installing Telegram Desktop..."
flatpak install -y flathub org.telegram.desktop
color_echo "green" "Telegram Desktop installed successfully."

# Install Office Productivity applications
color_echo "yellow" "Installing LibreOffice..."
dnf remove -y libreoffice*
flatpak install -y flathub org.libreoffice.LibreOffice
flatpak install -y --reinstall org.freedesktop.Platform.Locale/x86_64/24.08
flatpak install -y --reinstall org.libreoffice.LibreOffice.Locale
color_echo "green" "LibreOffice installed successfully."
color_echo "yellow" "Installing Obsidian..."
flatpak install -y flathub md.obsidian.Obsidian
color_echo "green" "Obsidian installed successfully."

# Install Media & Graphics applications
color_echo "yellow" "Installing VLC..."
flatpak install -y flathub org.videolan.VLC
color_echo "green" "VLC installed successfully."
color_echo "yellow" "Installing Stremio..."
flatpak install -y flathub com.stremio.Stremio
color_echo "green" "Stremio installed successfully."
color_echo "yellow" "Installing Krita..."
flatpak install -y flathub org.kde.krita
color_echo "green" "Krita installed successfully."
color_echo "yellow" "Installing Kdenlive..."
flatpak install -y flathub org.kde.kdenlive
color_echo "green" "Kdenlive installed successfully."
color_echo "yellow" "Installing Sly..."
flatpak install -y flathub page.kramo.Sly
color_echo "green" "Sly installed successfully."
color_echo "yellow" "Installing Gradia..."
flatpak install -y flathub be.alexandervanhee.gradia
color_echo "green" "Gradia installed successfully."
color_echo "yellow" "Installing Pinta..."
flatpak install -y flathub com.github.PintaProject.Pinta
color_echo "green" "Pinta installed successfully."

# Install Gaming & Emulation applications
color_echo "yellow" "Installing Steam..."
dnf install -y steam
color_echo "green" "Steam installed successfully."
color_echo "yellow" "Installing Heroic Games Launcher..."
flatpak install -y flathub com.heroicgameslauncher.hgl
color_echo "green" "Heroic Games Launcher installed successfully."

# Install Remote Networking applications
color_echo "yellow" "Installing Tailscale..."
dnf config-manager addrepo --from-repofile=https://pkgs.tailscale.com/stable/fedora/tailscale.repo
dnf install tailscale -y
systemctl enable --now tailscaled
color_echo "green" "Tailscale installed successfully."

# Install File Sharing & Download applications
color_echo "yellow" "Installing qBittorrent..."
flatpak install -y flathub org.qbittorrent.qBittorrent
color_echo "green" "qBittorrent installed successfully."
color_echo "yellow" "Installing LocalSend..."
flatpak install -y flathub org.localsend.localsend_app
color_echo "green" "LocalSend installed successfully."
color_echo "yellow" "Installing Parabolic..."
flatpak install -y flathub org.nickvision.tubeconverter
color_echo "green" "Parabolic installed successfully."
color_echo "yellow" "Installing Switcheroo..."
flatpak install -y flathub io.gitlab.adhami3310.Converter
color_echo "green" "Switcheroo installed successfully."
color_echo "yellow" "Installing Fragments..."
flatpak install -y flathub de.haeckerfelix.Fragments
color_echo "green" "Fragments installed successfully."

# Install System Tools applications
color_echo "yellow" "Installing Resources..."
flatpak install -y flathub net.nokyan.Resources
color_echo "green" "Resources installed successfully."
color_echo "yellow" "Installing Flatseal..."
flatpak install -y flathub com.github.tchx84.Flatseal
color_echo "green" "Flatseal installed successfully."
color_echo "yellow" "Installing Extension Manager..."
flatpak install -y flathub com.mattjakeman.ExtensionManager
color_echo "green" "Extension Manager installed successfully."
color_echo "yellow" "Installing Bottles..."
flatpak install -y flathub com.usebottles.bottles
color_echo "green" "Bottles installed successfully."
color_echo "yellow" "Installing Protonplus..."
flatpak install -y flathub com.vysp3r.ProtonPlus
color_echo "green" "Protonplus installed successfully."
color_echo "yellow" "Installing Protontricks..."
flatpak install -y flathub com.github.Matoking.protontricks
color_echo "green" "Protontricks installed successfully."
color_echo "yellow" "Installing Gear Lever..."
flatpak install -y flathub it.mijorus.gearlever
color_echo "green" "Gear Lever installed successfully."
color_echo "yellow" "Installing Bazaar..."
flatpak install -y flathub io.github.kolunmi.Bazaar
color_echo "green" "Bazaar installed successfully."

# Customization
# Install Adwaita theme for gtk3 apps
color_echo "yellow" "Installing adw-gtk3..."
flatpak install -y org.gtk.Gtk3theme.adw-gtk3 org.gtk.Gtk3theme.adw-gtk3-dark
color_echo "green" "adw-gtk3 installed successfully."

# Install Microsoft Windows fonts (core)
color_echo "yellow" "Installing Microsoft Fonts (core)..."
dnf install -y curl cabextract xorg-x11-font-utils fontconfig
rpm -i https://downloads.sourceforge.net/project/mscorefonts2/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm
color_echo "green" "Microsoft Fonts (core) installed successfully."

# Install Google fonts collection
color_echo "yellow" "Installing Google Fonts..."
wget -O /tmp/google-fonts.zip https://github.com/google/fonts/archive/main.zip
mkdir -p $ACTUAL_HOME/.local/share/fonts/google
unzip /tmp/google-fonts.zip -d $ACTUAL_HOME/.local/share/fonts/google
rm -f /tmp/google-fonts.zip
color_echo "green" "Google Fonts installed successfully."

# Install Adobe fonts collection
color_echo "yellow" "Installing Adobe Fonts..."
mkdir -p $ACTUAL_HOME/.local/share/fonts/adobe-fonts
git clone --depth 1 https://github.com/adobe-fonts/source-sans.git $ACTUAL_HOME/.local/share/fonts/adobe-fonts/source-sans
git clone --depth 1 https://github.com/adobe-fonts/source-serif.git $ACTUAL_HOME/.local/share/fonts/adobe-fonts/source-serif
git clone --depth 1 https://github.com/adobe-fonts/source-code-pro.git $ACTUAL_HOME/.local/share/fonts/adobe-fonts/source-code-pro
color_echo "green" "Adobe Fonts installed successfully."

# Install JetBrains Mono Nerd Font
[ ! -d "$HOME/.local/share/fonts" ] && mkdir -p "$HOME/.local/share/fonts"
DOWNLOADDIR=/tmp
wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip -P $DOWNLOADDIR
unzip $DOWNLOADDIR/JetBrainsMono.zip -d $DOWNLOADDIR/JetBrainsMono
cp -r $DOWNLOADDIR/JetBrainsMono "$HOME/.local/share/fonts/"
rm -rf $DOWNLOADDIR/JetBrainsMono.zip $DOWNLOADDIR/JetBrainsMono

fc-cache -fv

# Change shell to zsh
sudo chsh -s $(which zsh) herbatka

# Gnome workspace keybindings
sudo -u $ACTUAL_USER gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-1 "['<Shift><Super>1']"
sudo -u $ACTUAL_USER gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-2 "['<Shift><Super>2']"
sudo -u $ACTUAL_USER gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-3 "['<Shift><Super>3']"
sudo -u $ACTUAL_USER gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-4 "['<Shift><Super>4']"
sudo -u $ACTUAL_USER gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-5 "['<Shift><Super>5']"
sudo -u $ACTUAL_USER gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-6 "['<Shift><Super>6']"
sudo -u $ACTUAL_USER gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-7 "['<Shift><Super>7']"
sudo -u $ACTUAL_USER gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-8 "['<Shift><Super>8']"
sudo -u $ACTUAL_USER gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-9 "['<Shift><Super>9']"

sudo -u $ACTUAL_USER gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-1 "['<Super>1']"
sudo -u $ACTUAL_USER gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-2 "['<Super>2']"
sudo -u $ACTUAL_USER gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-3 "['<Super>3']"
sudo -u $ACTUAL_USER gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-4 "['<Super>4']"
sudo -u $ACTUAL_USER gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-5 "['<Super>5']"
sudo -u $ACTUAL_USER gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-6 "['<Super>6']"
sudo -u $ACTUAL_USER gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-7 "['<Super>7']"
sudo -u $ACTUAL_USER gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-8 "['<Super>8']"
sudo -u $ACTUAL_USER gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-9 "['<Super>9']"

# Gnome apps keybindings
sudo -u $ACTUAL_USER gsettings set org.gnome.shell.keybindings open-new-window-application-1 "['<Alt><Control>1']"
sudo -u $ACTUAL_USER gsettings set org.gnome.shell.keybindings open-new-window-application-2 "['<Alt><Control>2']"
sudo -u $ACTUAL_USER gsettings set org.gnome.shell.keybindings open-new-window-application-3 "['<Alt><Control>3']"
sudo -u $ACTUAL_USER gsettings set org.gnome.shell.keybindings open-new-window-application-4 "['<Alt><Control>4']"
sudo -u $ACTUAL_USER gsettings set org.gnome.shell.keybindings open-new-window-application-5 "['<Alt><Control>5']"
sudo -u $ACTUAL_USER gsettings set org.gnome.shell.keybindings open-new-window-application-6 "['<Alt><Control>6']"
sudo -u $ACTUAL_USER gsettings set org.gnome.shell.keybindings open-new-window-application-7 "['<Alt><Control>7']"
sudo -u $ACTUAL_USER gsettings set org.gnome.shell.keybindings open-new-window-application-8 "['<Alt><Control>8']"
sudo -u $ACTUAL_USER gsettings set org.gnome.shell.keybindings open-new-window-application-9 "['<Alt><Control>9']"

sudo -u $ACTUAL_USER gsettings set org.gnome.shell.keybindings switch-to-application-1 "['<Alt>1']"
sudo -u $ACTUAL_USER gsettings set org.gnome.shell.keybindings switch-to-application-2 "['<Alt>2']"
sudo -u $ACTUAL_USER gsettings set org.gnome.shell.keybindings switch-to-application-3 "['<Alt>3']"
sudo -u $ACTUAL_USER gsettings set org.gnome.shell.keybindings switch-to-application-4 "['<Alt>4']"
sudo -u $ACTUAL_USER gsettings set org.gnome.shell.keybindings switch-to-application-5 "['<Alt>5']"
sudo -u $ACTUAL_USER gsettings set org.gnome.shell.keybindings switch-to-application-6 "['<Alt>6']"
sudo -u $ACTUAL_USER gsettings set org.gnome.shell.keybindings switch-to-application-7 "['<Alt>7']"
sudo -u $ACTUAL_USER gsettings set org.gnome.shell.keybindings switch-to-application-8 "['<Alt>8']"
sudo -u $ACTUAL_USER gsettings set org.gnome.shell.keybindings switch-to-application-9 "['<Alt>9']"

# Gnome custom keymapings
declare -A shortcuts=(
    ["launch-terminal"]="Launch Terminal|ghostty|['<Super>Return']"
    ["launch-browser"]="Launch Browser|google-chrome|['<Super>b']"
    ["gradia-screenshot"]="Screenshot with Gradia|flatpak run be.alexandervanhee.gradia --screenshot=INTERACTIVE|['<Shift><Super>s']"
)

current_list=$(gsettings get org.gnome.settings-daemon.plugins.media-keys custom-keybindings | sed -e 's/^\[//' -e 's/\]$//' -e 's/, //g' -e "s/'//g")
IFS=' ' read -r -a existing_paths <<< "$current_list"

for id in "${!shortcuts[@]}"; do
    bind_path="/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/${id}/"
    IFS='|' read -r name command binding <<< "${shortcuts[$id]}"

    gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:$bind_path name "$name"
    gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:$bind_path command "$command"
    gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:$bind_path binding "$binding"

    if [[ ! " ${existing_paths[@]} " =~ " ${bind_path} " ]]; then
        existing_paths+=("$bind_path")
    fi
done

final_string=""
for path in "${existing_paths[@]}"; do
    if [ -n "$path" ]; then
        final_string+="'$path', "
    fi
done
final_string="[${final_string%, }]"

gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "$final_string"


# Custom user-defined commands
echo "Created with ❤️ for Open Source"


# Before finishing, ensure we're in a safe directory
cd /tmp || cd $ACTUAL_HOME || cd /

# Finish
echo "";
echo "╔═════════════════════════════════════════════════════════════════════════╗";
echo "║                                                                         ║";
echo "║   ░█░█░█▀▀░█░░░█▀▀░█▀█░█▄█░█▀▀░░░▀█▀░█▀█░░░█▀▀░█▀▀░█▀▄░█▀█░█▀▄░█▀█░█░   ║";
echo "║   ░█▄█░█▀▀░█░░░█░░░█░█░█░█░█▀▀░░░░█░░█░█░░░█▀▀░█▀▀░█░█░█░█░█▀▄░█▀█░▀░   ║";
echo "║   ░▀░▀░▀▀▀░▀▀▀░▀▀▀░▀▀▀░▀░▀░▀▀▀░░░░▀░░▀▀▀░░░▀░░░▀▀▀░▀▀░░▀▀▀░▀░▀░▀░▀░▀░   ║";
echo "║                                                                         ║";
echo "╚═════════════════════════════════════════════════════════════════════════╝";
echo "";
color_echo "green" "All steps completed. Enjoy!"

# Prompt for reboot
prompt_reboot
