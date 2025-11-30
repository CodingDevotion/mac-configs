#!/usr/bin/env bash

register_tool "nvim"

tool_nvim_setup() {
  local src="$CONFIG_DIR/nvim"
  local dest="$HOME/.config/nvim"

  if [ -d "$src" ]; then
    backup_and_link "$src" "$dest"
  else
    warn "config/nvim not found in repo."
  fi
}

tool_nvim_verify() {
  verify_tool_bin nvim
}
