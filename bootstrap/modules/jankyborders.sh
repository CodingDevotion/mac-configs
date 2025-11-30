#!/usr/bin/env bash

register_tool "jankyborders"

tool_jankyborders_setup() {
  local src="$CONFIG_DIR/jankyborders"
  local dest="$HOME/.config/borders"

  if [ -d "$src" ]; then
    backup_and_link "$src" "$dest"
  else
    warn "config/jankyborders missing"
  fi
}

tool_jankyborders_verify() {
  verify_tool_bin borders
}
