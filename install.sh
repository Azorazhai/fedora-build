#!/bin/bash

# Check if Script is Run as Root
if [[ $EUID -ne 0 ]]; then
  echo "You must be a root user to run this script, please run sudo ./install.sh" 2>&1
  exit 1
fi

# Updating System
dnf update -y

# Making .config and Moving dotfiles and Background to .config
mkdir ~/.config
chown $(whoami): ~/.config
mv ./dotconfig/* ~/.config
mv ./nord-wind.jpg ~/.config

# Installing Essential Programs 
dnf install -y sddm bspwm sxhkd kitty rofi polybar picom thunar nitrogen lxpolkit

# Installing Other less important Programs
dnf install -y gimp lxappearance neofetch lnav wget curl

# Install zsh
sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"

# Install neovim 0.8
wget https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.tar.gz
tar xzvf nvim-linux64.tar.gz
echo 'alias nvim="~/nvim-linux64/bin/nvim"' >> ~/.zshrc

# adding btop
wget https://github.com/aristocratos/btop/releases/download/v1.2.8/btop-x86_64-linux-musl.tbz
tar xzvf btop-x86_64-linux-musl.tbz
~/btop-x86_64-linux-musl/install.sh

# Install starship
curl -sS https://starship.rs/install.sh | sh
echo 'eval "$(starship init zsh)"' >> ~/.zshrc

# Installing Custom ocs-url package
dnf install ./rpm-packages/ocs-url-3.1.0-1.fc20.x86_64.rpm

# Installing fonts
dnf install fontawesome-fonts fontawesome-fonts-web
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FiraCode.zip
unzip FiraCode.zip -d /usr/share/fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Meslo.zip
unzip Meslo.zip -d /usr/share/fonts
# Reloading Font
fc-cache -vf
# Removing zip Files
rm ./FiraCode.zip ./Meslo.zip

# More programs and dependencies 
sudo dnf install -y papirus-icon-theme arandr firefox pavucontrol pulseaduio pipewire inkscape tumbler dnfdragora dnfdragora-gui

# Install Brave 
dnf install -y dnf-plugins-core
dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/x86_64/
rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
dnf install -y brave-browser

# Install Chrome
dnf install -y fedora-workstation-repositories
dnf config-manager --set-enabled google-chrome
dnf install -y google-chrome-stable

# Enabling Services and Graphical User Interface
systemctl enable sddm
systemctl set-default graphical.target
