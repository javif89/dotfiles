# Install the following packages:
# Hyprland
# swaybg
# waybar
# kitty
# GNU stow
# Stow
# Sync dot files with stow symlinks

# Utility functions for the script
pac() {
  sudo pacman -S --noconfirm "$@"
}

logsetup() {
  echo "*** Setting up: $1 ***"
}

# Package setup functions
waybar() {
  logsetup "waybar"

  pac waybar
  # Since I'm using stow these should not be needed
  # mkdir ~/.config/waybar
  # cp -a /etc/xdg/waybar/. ~/.config/waybar
}

hyprland() {
  logsetup "Hyprland"

  pac hyprland xdg-desktop-portal-hyprland swaybg
}

kitty() {
  logsetup "Kitty"

  pac kitty
}

stw() {
  logsetup "GNU Stow"

  pac stow
}

chromium() {
  pac chromium
}

hyprland;
# waybar;
# kitty;
# chromium;
# stw
# pac helix
# pac git
# pac base-devel
# pac pipewire
# pac pipewire-pulse
# pac pipewire-alsa
# pac wireplumber
# pac mako

# echo "Syncing config files"
# rm ~/.bash_profile && rm ~/.bashrc
# stow .

# echo "Setting up yay"

# mkdir -p "$HOME/yaytemp"
# cd "$HOME/yaytemp"
# git clone https://aur.archlinux.org/yay.git
# cd yay
# makepkg -si

# echo "Installing fonts"
# sudo chmod +x ./install-fonts.sh
# ./install-fonts.sh

# echo "Cleanup"

# rm -rf "$HOME/yaytemp"

# echo "You should be ready to go"
