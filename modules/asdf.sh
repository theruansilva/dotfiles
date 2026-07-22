#!/bin/bash

DOTFILES_DIR="$HOME/dotfiles"
source "$DOTFILES_DIR/lib/utils.sh"

u_header "ASDF Version Manager"

if ! type -p asdf >/dev/null; then
    u_bold "Installing asdf..."
    yay -S --noconfirm asdf-vm
    # Add to current session
    source /opt/asdf-vm/asdf.sh
fi

languages=("golang" "bun" "rust" "lua", "uv" )

for lang in "${languages[@]}"; do
    u_bold "Installing $lang (latest)..."
    asdf plugin add "$lang" 2>/dev/null
    asdf install "$lang" latest
    asdf set -u "$lang" latest
done

u_success "ASDF languages installed"
