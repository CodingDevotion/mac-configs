#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BOOTSTRAP_DIR="$REPO_DIR/bootstrap"

# Load shared logic + globals
# shellcheck source=/dev/null
. "$BOOTSTRAP_DIR/lib.sh"

main() {
  log "Starting mac-configs bootstrap..."

  ensure_macos
  ensure_xcode_cli
  ensure_homebrew
  brew_bundle "$REPO_DIR/Brewfile"

  # Load each module: bootstrap/modules/*.sh
  for f in "$BOOTSTRAP_DIR/modules/"*.sh; do
    # shellcheck source=/dev/null
    . "$f"
  done

  run_phase "setup"
  run_phase "verify"

  log "Done. Re-run any time to update tools & configs."
}

main "$@"
