#!/usr/bin/env bash
set -euo pipefail

# --- Globals --------------------------------------------------------------

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CONFIG_DIR="$REPO_DIR/config"
MODULES_DIR="$REPO_DIR/bootstrap/modules"

TOOLS=()  # Each module calls register_tool "<name>"

log()  { printf "\033[1;32m[mac-configs]\033[0m %s\n" "$*"; }
warn() { printf "\033[1;33m[mac-configs WARN]\033[0m %s\n" "$*"; }
err()  { printf "\033[1;31m[mac-configs ERROR]\033[0m %s\n" "$*\n" >&2; }

register_tool() {
  TOOLS+=("$1")
}

run_phase() {
  local phase="$1"
  log "=== phase: $phase ==="
  for tool in "${TOOLS[@]}"; do
    local fn="tool_${tool}_${phase}"
    if declare -f "$fn" >/dev/null 2>&1; then
      log "--- [$tool] $phase ---"
      "$fn"
    else
      warn "No function $fn defined for tool '$tool'"
    fi
  done
}

backup_and_link() {
  local src="$1"
  local dest="$2"

  mkdir -p "$(dirname "$dest")"

  if [ -L "$dest" ]; then
    local current
    current="$(readlink "$dest")"
    if [ "$current" = "$src" ]; then
      log "Symlink already correct: $dest → $src"
      return
    fi
    local backup="${dest}.backup-$(date +%Y%m%d%H%M%S)"
    mv "$dest" "$backup"
    log "Backed up existing symlink to $backup"
  elif [ -e "$dest" ]; then
    local backup="${dest}.backup-$(date +%Y%m%d%H%M%S)"
    mv "$dest" "$backup"
    log "Backed up existing file/dir to $backup"
  fi

  ln -s "$src" "$dest"
  log "Linked $dest → $src"
}

ensure_macos() {
  if [ "$(uname)" != "Darwin" ]; then
    err "This repo is intended for macOS."
    exit 1
  fi
}

ensure_xcode_cli() {
  if ! xcode-select -p >/dev/null 2>&1; then
    log "Installing Xcode Command Line Tools..."
    xcode-select --install || warn "You may need to finish manually."
  else
    log "Xcode Command Line Tools already installed."
  fi
}

ensure_homebrew() {
  if command -v brew >/dev/null 2>&1; then
    log "Homebrew found. Updating..."
    brew update
  else
    log "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    if [ -d "/opt/homebrew/bin" ]; then
      export PATH="/opt/homebrew/bin:$PATH"
    fi
  fi
}

brew_bundle() {
  local brewfile="$1"
  if [ -f "$brewfile" ]; then
    log "Running brew bundle..."
    brew bundle --file="$brewfile"
  else
    warn "Brewfile not found: $brewfile"
  fi
}

verify_tool_bin() {
  local name="$1"
  if command -v "$name" >/dev/null 2>&1; then
    log "$name is installed"
  else
    warn "$name NOT found"
  fi
}
