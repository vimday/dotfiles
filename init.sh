#!/bin/bash

cd "$(dirname "$0")"

# Simple colored output functions
print_msg() { echo -e "\033[${1}m$2\033[0m"; }

error() { print_msg "31" "  $1"; } # Red
warn() { print_msg "33" "  $1"; }  # Yellow
info() { print_msg "32" "  $1"; }  # Green

# Link a dotfile/directory to the appropriate location
mkln() {
  local src=$(realpath "$1")
  local dst="${2:-$HOME/.config/$(basename "$src")}"
  local name=$(basename "$src")
  local desc="$3"

  if [ ! -e "$src" ]; then
    error "$name does not exist"
    return 1
  fi

  if [ ! -e "$dst" ]; then
    ln -s "$src" "$dst"
    info "$name -> $dst"
    [ -n "$desc" ] && echo "$desc"
  else
    warn "$name already exists"
  fi
}

# Install TPM (Tmux Plugin Manager)
tpm_path="$HOME/.tmux/plugins/tpm"
if [ ! -d "$tpm_path" ]; then
  git clone https://github.com/tmux-plugins/tpm "$tpm_path"
  info "TPM installed"
else
  warn "TPM already exists"
fi

my_busybox_path="$HOME/my-busybox"
if [ ! -d "$my_busybox_path" ]; then
  git clone https://github.com/Crescent617/my-busybox.git "$my_busybox_path"
  info "my-busybox installed"
else
  warn "my-busybox already exists"
fi

# Link configuration directories
mkln "./home-manager" "" "Run 'home-manager init' to initialize home-manager. Then follow home-manager/README.md to modify the home.nix."
mkln "./awesome"
mkln "./nvim"
