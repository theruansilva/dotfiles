#!/bin/bash

DOTFILES_DIR="$HOME/dotfiles"
source "$DOTFILES_DIR/lib/utils.sh"

u_header "Yazi"

CONFIG_DIR="$HOME/.config/yazi"
mkdir -p "$CONFIG_DIR"

u_bold "Linking yazi config..."
ln -sf "$DOTFILES_DIR/config/yazi/yazi.toml" "$CONFIG_DIR/yazi.toml"
ln -sf "$DOTFILES_DIR/config/yazi/theme.toml" "$CONFIG_DIR/theme.toml"
ln -sf "$DOTFILES_DIR/config/yazi/keymap.toml" "$CONFIG_DIR/keymap.toml"

# Link flavors directory if it exists
if [ -d "$DOTFILES_DIR/config/yazi/flavors" ]; then
    u_bold "Linking yazi flavors..."
    rm -rf "$CONFIG_DIR/flavors"
    ln -sf "$DOTFILES_DIR/config/yazi/flavors" "$CONFIG_DIR/flavors"
fi

u_success "Yazi setup complete"
