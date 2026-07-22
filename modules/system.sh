#!/bin/bash

DOTFILES_DIR="$HOME/dotfiles"
source "$DOTFILES_DIR/lib/utils.sh"

u_header "System Update & Base Packages"

u_bold "Updating system with yay..."
yay -Syu --noconfirm

u_bold "Installing base packages..."
yay -S --noconfirm \
    yaml-cpp unzip asdf-vm make gcc xh curl fzf libyaml ripgrep zsh git cmake mesa \
    docker docker-compose docker-machine docker-buildx unixodbc sxhkd gyp \
    bat fakeroot pkgconf neovim fd btop carapace-bin \
    gnome-tweaks dconf-editor zoxide lazydocker lazygit yazi \
    antigravity sassc exa

u_success "System base setup complete"
