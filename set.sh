#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1"
}

error() {
    echo "[ERROR] $1" >&2
    exit 1
}

safe_remove() {
    local target="$1"
    if [[ -e "$target" ]]; then
        log "Removing existing $target"
        rm -rf "$target"
    fi
}

create_symlink() {
    local source="$1"
    local target="$2"
    local description="$3"

    if [[ ! -e "$source" ]]; then
        error "Source file $source does not exist"
    fi

    safe_remove "$target"
    log "Creating symlink: $description"
    ln -s "$source" "$target"
}

setup_shell_config() {
    log "Setting up shell configuration"

    safe_remove ~/.bashrc

    create_symlink "$SCRIPT_DIR/.bashrc" ~/.bashrc "bash configuration"

    safe_remove ~/.gitconfig
    echo "[include]" > ~/.gitconfig
    echo "path = $SCRIPT_DIR/.gitconfig" >> ~/.gitconfig
    log "Git configuration setup complete"
}

main() {
    log "Starting environment setup for Git Bash"

    setup_shell_config

    log "Environment setup completed successfully!"
    log "Please restart Git Bash to apply changes."
}

main "$@"
