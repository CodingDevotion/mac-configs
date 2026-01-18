#!/usr/bin/env bash

register_tool "kitty"

tool_kitty_setup() {
  local src="$CONFIG_DIR/kitty"
  local dest="$HOME/.config/kitty"

  # Create config directory if it doesn't exist
  mkdir -p "$CONFIG_DIR/kitty"

  # Link kitty config directory
  if [ -d "$src" ] && [ -f "$src/kitty.conf" ]; then
    backup_and_link "$src" "$dest"
  else
    warn "kitty config not found in repo"
  fi
}

tool_kitty_postinstall() {
  log "Kitty configuration complete"
}

tool_kitty_verify() {
  verify_tool_bin kitty
  
  if [ -f "$HOME/.config/kitty/kitty.conf" ]; then
    log "kitty.conf config file found"
  else
    warn "kitty.conf config file not found"
  fi
}
