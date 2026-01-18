#!/usr/bin/env bash

register_tool "zoxide"

tool_zoxide_setup() {
    brew install zoxide
}

tool_zoxide_postinstall() {
    add_zshrc 'eval "$(zoxide init zsh)"'
}

tool_zoxide_verify() {
  verify_tool_bin zoxide
}
