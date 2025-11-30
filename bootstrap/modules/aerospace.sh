#!/usr/bin/env bash

register_tool "aerospace"

tool_aerospace_setup() {
  local src="$CONFIG_DIR/aerospace"
  local dest="$HOME/.config/aerospace"

  if [ -d "$src" ]; then
    backup_and_link "$src" "$dest"
  else
    warn "config/aerospace missing"
  fi
}

tool_aerospace_verify() {
  verify_tool_bin aerospace
}
