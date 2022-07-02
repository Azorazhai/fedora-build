#!/bin/bash

# Check if Script is Run as Root
#if [[ $EUID -ne 0 ]]; then
#  echo "You must be a root user to run this script, please run sudo ./install.sh" 2>&1
#  exit 1
#fi

# Updating System
sudo dnf update -y

# Making .config and Moving dotfiles and Background to .config
mkdir ~/.config
chown $(whoami): ~/.config
mv ./dotconfig/* ~/.config
mv ./nord-wind.jpg ~/.config
mv .xinitrc ~/
mv .X* ~/


# Installing Essential Programs 
sudo dnf install -y sddm sddm-breeze bspwm sxhkd kitty rofi polybar picom thunar nitrogen lxpolkit

# Installing Other less important Programs
sudo dnf install -y gimp vim lxappearance neofetch lnav wget curl zsh dconf-editor

# Install starship
curl -sS https://starship.rs/install.sh | sh

# Installing Custom ocs-url package
sudo dnf install ./rpm-packages/ocs-url-3.1.0-1.fc20.x86_64.rpm

# Installing fonts
sudo dnf install fontawesome-fonts fontawesome-fonts-web
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FiraCode.zip
sudo unzip FiraCode.zip -d /usr/share/fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Meslo.zip
sudo unzip Meslo.zip -d /usr/share/fonts
# Reloading Font
sudo fc-cache -vf
# Removing zip Files
rm ./FiraCode.zip ./Meslo.zip

# More programs and dependencies 
sudo dnf install -y papirus-icon-theme arandr firefox pavucontrol pipewire inkscape tumbler dnfdragora dnfdragora-gui
sudo dnf install -y alsa-lib-devel ncurses-devel fftw3-devel pulseaudio-libs-devel libtool cava

# Install Brave 
sudo dnf install -y dnf-plugins-core
sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/x86_64/
sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
sudo dnf install -y brave-browser

# Install Chrome
sudo dnf install -y fedora-workstation-repositories
sudo dnf config-manager --set-enabled google-chrome
sudo dnf install -y google-chrome-stable

# Enabling Services and Graphical User Interface
sudo systemctl enable sddm
sudo systemctl set-default graphical.target

# adding btop
wget https://github.com/aristocratos/btop/releases/download/v1.2.8/btop-x86_64-linux-musl.tbz
mkdir btop
tar xjvf btop-x86_64-linux-musl.tbz -C btop
sudo btop/install.sh


# Install zsh
sudo sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"

# Install neovim 0.8
wget https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.tar.gz
tar xzvf nvim-linux64.tar.gz
echo 'alias nvim="~/nvim-linux64/bin/nvim"' >> ~/.zshrc
echo 'eval "$(starship init zsh)"' >> ~/.zshrc
