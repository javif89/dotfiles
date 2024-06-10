#! /usr/bin/bash

# Shortcut for installing without prompts
# and only if packages are not currently installed
install() {
  sudo pacman -Sg "$@" --needed
}

# wget if we don't have it
install wget

# Docker client and docker compose util
install docker docker-compose
# Docker desktop and it's requirements
install gnome-terminal --needed
install procps

mkdir -p ddtemp && cd ddtemp
wget "https://desktop.docker.com/linux/main/amd64/153195/docker-desktop-4.31.0-x86_64.pkg.tar.zst"
sudo pacman -U ./docker-desktop-4.31.0-x86_64.pkg.tar.zst
cd ../
rm -rf ddtemp
echo "Done"
