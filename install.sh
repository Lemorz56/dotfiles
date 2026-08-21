#!/usr/bin/env bash
# Symlink every package in this repo into $HOME with GNU Stow.
#
# Usage:
#   ./install.sh              # stow every package (excluding nvim-bak)
#   ./install.sh nvim tmux    # stow only the packages you name
#   ./install.sh --adopt zsh  # pull an existing ~/.zshrc INTO this repo first
#                              # (see the warning about --adopt in README.md)

set -euo pipefail
cd "$(dirname "${BASH_SOURCE[0]}")"

if ! command -v stow >/dev/null 2>&1; then
  echo "GNU Stow isn't installed. Install it first:" >&2
  echo "  macOS:   brew install stow" >&2
  echo "  Debian/Ubuntu: sudo apt install stow" >&2
  exit 1
fi

ADOPT=""
if [[ "${1:-}" == "--adopt" ]]; then
  ADOPT="--adopt"
  shift
fi

if [[ $# -gt 0 ]]; then
  PACKAGES=("$@")
else
  # Every top-level dir except nvim-bak (that one's a backup, stow it
  # explicitly with `./install.sh nvim-bak` if you actually want it linked).
  PACKAGES=()
  for d in */; do
    name="${d%/}"
    [[ "$name" == "nvim-bak" ]] && continue
    PACKAGES+=("$name")
  done
fi

echo "Stowing: ${PACKAGES[*]}"
stow -t "$HOME" -v $ADOPT "${PACKAGES[@]}"
