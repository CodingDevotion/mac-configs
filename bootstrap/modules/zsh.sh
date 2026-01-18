#!/usr/bin/env bash

register_tool "zsh"

tool_zsh_setup() {
  # Install oh-my-zsh first (before linking .zshrc which depends on it)
  if [ ! -d "$HOME/.oh-my-zsh" ]; then
    log "Installing oh-my-zsh..."
    # Use non-interactive install
    RUNZSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    log "oh-my-zsh installed"
  else
    log "oh-my-zsh already installed"
  fi

  # Install powerlevel10k theme if not already installed
  if [ ! -d "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" ]; then
    log "Installing powerlevel10k theme..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" 2>/dev/null || {
      warn "Failed to install powerlevel10k. It may already be installed or git may not be available."
    }
  else
    log "powerlevel10k theme already installed"
  fi

  local zshrc_src="$CONFIG_DIR/zsh/.zshrc"
  local zshrc_dest="$HOME/.zshrc"
  local p10k_src="$CONFIG_DIR/zsh/.p10k.zsh"
  local p10k_dest="$HOME/.p10k.zsh"

  # Create config directory if it doesn't exist
  mkdir -p "$CONFIG_DIR/zsh"

  # Link .zshrc
  if [ -f "$zshrc_src" ]; then
    backup_and_link "$zshrc_src" "$zshrc_dest"
  else
    warn ".zshrc not found in repo"
  fi

  # Link .p10k.zsh if it exists in repo
  if [ -f "$p10k_src" ]; then
    backup_and_link "$p10k_src" "$p10k_dest"
  fi
}

tool_zsh_postinstall() {
  log "zsh configuration complete"
}

tool_zsh_verify() {
  verify_tool_bin zsh
  
  if [ -d "$HOME/.oh-my-zsh" ]; then
    log "oh-my-zsh is installed"
  else
    warn "oh-my-zsh NOT found"
  fi

  if [ -f "$HOME/.zshrc" ]; then
    log ".zshrc file found"
  else
    warn ".zshrc NOT found"
  fi
}
