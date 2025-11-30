# 💻 **mac-configs**

A fully automated, modular, and repeatable macOS development setup.
One command transforms a fresh Mac → a complete dev environment.

---

## 🚀 **Quick Start**

```bash
git clone https://github.com/CodingDevotion/mac-configs.git

cd mac-configs

make bootstrap
```

This will automatically:

- Install or update Homebrew
- Install all tools listed in the Brewfile

- Symlink configuration files from config/
- Run optional post-install hooks (e.g., start services)

- Verify that all tools are installed and functional

Re-run make bootstrap anytime — the process is 100% idempotent.

## 🧰 Tools Installed & Configured

This repo sets up the following tools (fully modular — enable/disable as you wish):

### Core

- Git — global .gitconfig

- Zsh — shell configuration + Oh-My-Zsh

- Neovim — full init.lua setup with lazy.nvim, LSP, and Treesitter

- VS Code — settings, keybindings, and extensions auto-installed

### Window Management

- Aerospace — dynamic tiling window manager

- SketchyBar — status bar

### Developer Tools (via Brewfile)

- Homebrew itself

- Others you add to the Brewfile

## 😎 Why This Exists

Setting up a new Mac shouldn’t take hours.
This repo gives you a setup that is:

- Deterministic — all configs live in version control
- Automated — no manual steps or copy-pasting commands

- Modular — each tool is isolated in its own bootstrap module
- Extensible — add new tools or configs in seconds

Perfect for wiping a machine, onboarding a new Mac, or keeping multiple Macs in sync.
