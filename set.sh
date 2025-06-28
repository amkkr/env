#!/bin/zsh

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

safe_mkdir() {
    local dir="$1"
    if [[ ! -d "$dir" ]]; then
        log "Creating directory $dir"
        mkdir -p "$dir"
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

check_dependencies() {
    local deps=("curl" "wget" "zsh")
    for dep in "${deps[@]}"; do
        if ! command -v "$dep" &> /dev/null; then
            error "Required dependency '$dep' not found. Please install it first."
        fi
    done
}

setup_shell_config() {
    log "Setting up shell configuration"
    
    safe_remove ~/.bash*
    safe_remove ~/.zsh*
    
    create_symlink "$SCRIPT_DIR/.zshrc" ~/.zshrc "zsh configuration"
    
    safe_remove ~/.gitconfig
    echo "[include]" > ~/.gitconfig
    echo "path = $SCRIPT_DIR/.gitconfig" >> ~/.gitconfig
    log "Git configuration setup complete"
}

setup_neovim() {
    log "Setting up NeoVim configuration"
    
    safe_remove ~/.config/nvim
    safe_mkdir ~/.config
    create_symlink "$SCRIPT_DIR/nvim" ~/.config/nvim "NeoVim configuration"
}

setup_warp_terminal() {
    log "Setting up Warp terminal configuration"
    
    case "${OSTYPE}" in
        linux*)
            safe_mkdir ~/.config
            if [[ ! -L ~/.config/warp-terminal ]]; then
                create_symlink "$SCRIPT_DIR/warp-terminal" ~/.config/warp-terminal "Warp terminal (Linux)"
            fi
            ;;
        darwin*)
            safe_mkdir ~/.warp
            if [[ -d ~/.warp && ! -L ~/.warp ]]; then
                safe_remove ~/.warp/*
            fi
            create_symlink "$SCRIPT_DIR/darwin-mac.yaml" ~/.warp/keybindings.yaml "Warp keybindings (macOS)"
            ;;
        *)
            log "Unsupported OS type: $OSTYPE, skipping Warp terminal setup"
            ;;
    esac
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
    fi
}

install_dvm() {
    log "Installing Deno Version Manager (dvm)"
    
    if curl -fsSL https://dvm.deno.dev | sh; then
        log "dvm installed successfully"
    else
        error "Failed to install dvm"
    fi
}

install_nvm() {
    log "Installing Node Version Manager (nvm)"
    
    if curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash; then
        log "nvm installed successfully"
    else
        error "Failed to install nvm"
    fi
}

main() {
    log "Starting environment setup"
    
    check_dependencies
    setup_shell_config
    setup_neovim
    setup_warp_terminal
    
    if [[ -f ~/.zshrc ]]; then
        source ~/.zshrc
    fi
    
    setup_git_completion
    setup_vim_jetpack
    install_dvm
    install_nvm
    
    if [[ -f ~/.zshrc ]]; then
        source ~/.zshrc
    fi
    
    log "Environment setup completed successfully!"
}

main "$@"
