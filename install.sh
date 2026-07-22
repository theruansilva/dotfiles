#!/bin/bash

# =============================================================================
# Manjaro Dotfiles Installer
# =============================================================================

# Set error handling
set -e

# Define directories
DOTFILES_DIR="$HOME/dotfiles"
LIB_DIR="$DOTFILES_DIR/lib"

# Load utilities
if [ -f "$LIB_DIR/utils.sh" ]; then
    source "$LIB_DIR/utils.sh"
else
    echo "Error: Could not find $LIB_DIR/utils.sh"
    exit 1
fi

# -----------------------------------------------------------------------------
# Bootstrap
# -----------------------------------------------------------------------------

u_header "Manjaro Setup"

# Ensure we are in the dotfiles directory
cd "$DOTFILES_DIR"

# -----------------------------------------------------------------------------
# Installation Phases
# -----------------------------------------------------------------------------

# Phase 1: System Base
u_header "Phase 1: System Base"
bash modules/system.sh
bash modules/yay.sh

# Phase 2: Core Shell & Git
u_header "Phase 2: Core Shell & Git"
bash modules/zsh.sh
bash modules/git.sh
bash modules/asdf.sh
bash modules/gh.sh
bash modules/fzf.sh
bash modules/starship.sh

# Phase 3: Development Tools
u_header "Phase 3: Development Tools"
bash modules/tmux.sh
bash modules/docker.sh
bash modules/ollama.sh
bash modules/fabric.sh
bash modules/psql.sh
bash modules/ngrok.sh
bash modules/lazygit.sh
bash modules/lazydocker.sh
bash modules/yazi.sh

# Phase 4: Desktop & UI
u_header "Phase 4: Desktop & UI"
bash modules/font.sh
bash modules/kitty.sh
bash modules/alacritty.sh
bash modules/gnome.sh
bash modules/flatpak.sh

# Phase 5: Neovim (The Masterpiece)
u_header "Phase 5: Neovim"
# Ensure gh is authenticated if needed for private repos
# u_bold "Note: Neovim setup might require 'gh auth login' first if repo is private."
bash modules/nvim.sh

# -----------------------------------------------------------------------------
# Finalize
# -----------------------------------------------------------------------------

u_header "Installation Complete!"
u_success "All modules have been processed."
u_bold "Please restart your terminal or run: source ~/.zshrc"
u_bold "Install Tmux plugins by running Ctrl+G I"
u_bold "Don't forget to run 'gh auth login' to finish GitHub setup."
