#!/usr/bin/env bash

register_tool "sketchybar"

tool_sketchybar_setup() {
  local src="$CONFIG_DIR/sketchybar"
  local dest="$HOME/.config/sketchybar"

  if [ -d "$src" ]; then
    backup_and_link "$src" "$dest"
  else
    warn "config/sketchybar missing"
  fi
}

tool_sketchybar_postinstall() {
    ensure_brew_service_started sketchybar
}

tool_sketchybar_verify() {
  verify_tool_bin sketchybar
}
