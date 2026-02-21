#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

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
<<<<<<< HEAD:set.sh

    safe_remove ~/.bashrc

    create_symlink "$SCRIPT_DIR/.bashrc" ~/.bashrc "bash configuration"

=======
    
    for f in ~/.bash*(N) ~/.zshrc(N) ~/.zshenv(N) ~/.zprofile(N) ~/.zlogin(N) ~/.zlogout(N) ~/.zsh_history(N); do
        safe_remove "$f"
    done
    
    create_symlink "$SCRIPT_DIR/.zshrc" ~/.zshrc "zsh configuration"
    
>>>>>>> master:set.zsh
    safe_remove ~/.gitconfig
    echo "[include]" > ~/.gitconfig
    echo "path = $SCRIPT_DIR/.gitconfig" >> ~/.gitconfig
    log "Git configuration setup complete"
}

setup_nvim_config() {
    log "Setting up NeoVim configuration"

<<<<<<< HEAD:set.sh
    local nvim_config_dir="$HOME/AppData/Local/nvim"
    local nvim_source_dir="$SCRIPT_DIR/nvim"

    if [[ ! -d "$nvim_source_dir" ]]; then
        error "NeoVim configuration directory $nvim_source_dir does not exist"
=======
setup_warp_terminal() {
    log "Setting up Warp terminal configuration"

    case "${OSTYPE}" in
        darwin*)
            safe_mkdir ~/.warp
            if [[ -d ~/.warp && ! -L ~/.warp ]]; then
                for f in ~/.warp/*(N); do
                    safe_remove "$f"
                done
            fi
            create_symlink "$SCRIPT_DIR/warp/keybindings.yaml" ~/.warp/keybindings.yaml "Warp keybindings (macOS)"
            safe_mkdir ~/.warp/themes
            create_symlink "$SCRIPT_DIR/warp/themes/gruvbox-dark-soft.yaml" ~/.warp/themes/gruvbox-dark-soft.yaml "Warp theme (macOS)"
            ;;
        *)
            log "Unsupported OS type: $OSTYPE, skipping Warp terminal setup"
            ;;
    esac
}

setup_claude_config() {
    log "Setting up Claude Code configuration"

    safe_mkdir ~/.claude
    create_symlink "$SCRIPT_DIR/.claude.md" ~/.claude/CLAUDE.md "Claude Code configuration"
}

setup_git_completion() {
    log "Setting up git completion and prompt"
    
    safe_mkdir ~/.zsh
    
    local git_files=(
        "git-completion.bash:~/.zsh/git-completion.bash"
        "git-prompt.sh:~/.zsh/git-prompt.sh"
        "git-completion.zsh:~/.zsh/_git"
    )
    
    for file_mapping in "${git_files[@]}"; do
        local filename="${file_mapping%:*}"
        local target="${file_mapping#*:}"
        local url="https://raw.githubusercontent.com/git/git/master/contrib/completion/$filename"
        
        log "Downloading $filename"
        if wget "$url" -O "${target/#\~/$HOME}" 2>/dev/null; then
            chmod +x "${target/#\~/$HOME}"
        else
            error "Failed to download $filename"
        fi
    done
}

setup_vim_jetpack() {
    log "Installing vim-jetpack"
    
    local jetpack_dir="$HOME/.local/share/nvim/site/pack/jetpack/opt/vim-jetpack/plugin"
    safe_mkdir "$jetpack_dir"
    
    if curl -fLo "$jetpack_dir/jetpack.vim" \
        https://raw.githubusercontent.com/tani/vim-jetpack/master/plugin/jetpack.vim 2>/dev/null; then
        log "vim-jetpack installed successfully"
    else
        error "Failed to install vim-jetpack"
>>>>>>> master:set.zsh
    fi

    # Create parent directory if it doesn't exist
    mkdir -p "$HOME/AppData/Local"

    safe_remove "$nvim_config_dir"

<<<<<<< HEAD:set.sh
    log "Creating symlink for NeoVim configuration"
    ln -s "$nvim_source_dir" "$nvim_config_dir"

    log "NeoVim configuration setup complete"
=======
    if curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | zsh; then
        log "nvm installed successfully"
    else
        error "Failed to install nvm"
    fi
>>>>>>> master:set.zsh
}

main() {
    log "Starting environment setup for Git Bash"

    setup_shell_config
<<<<<<< HEAD:set.sh
    setup_nvim_config
=======
    setup_neovim
    setup_warp_terminal
    setup_claude_config
    setup_git_completion
>>>>>>> master:set.zsh

    log "Environment setup completed successfully!"
    log "Please restart Git Bash to apply changes."
}

main "$@"
