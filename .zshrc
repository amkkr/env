# =============================================================================
# ZSH Configuration
# =============================================================================

# -----------------------------------------------------------------------------
# Basic Configuration
# -----------------------------------------------------------------------------
autoload colors && colors

# History configuration
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

# Key bindings
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey "^[[H"    beginning-of-line
bindkey "^[[F"    end-of-line
bindkey "^[[3~"   delete-char

# -----------------------------------------------------------------------------
# Git Integration and Prompt
# -----------------------------------------------------------------------------
source ~/.zsh/git-prompt.sh
fpath=(~/.zsh $fpath)
zstyle ':completion:*:*:git:*' script ~/.zsh/git-completion.bash
autoload -Uz compinit && compinit -u

# Git prompt options
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWUPSTREAM=auto
GIT_PS1_SHOWCOLORHINTS=true

# Root user indicator
if [ ${UID} -eq 0 ]; then
    ISROOT="%K{red}%F{black}ROOT %k%f"
fi
RPROMPT="${ISROOT}"

# Prompt configuration
setopt PROMPT_SUBST
PS1='[%B%F{green}%n%f%b@%B%F{green}%m%f:%F{blue}%~%f%b] $(__git_ps1 "(%s)")'$'\n'

# -----------------------------------------------------------------------------
# Platform-Specific Configuration
# -----------------------------------------------------------------------------
case ${OSTYPE} in
    linux*)
        # Linux aliases and settings
        alias ls='ls --color=auto'
        alias upd='sudo zypper ref && sudo zypper up -y'
        # Alternative package managers (commented out)
        # alias upd='sudo dnf upgrade -y && sudo dnf autoremove'
        # alias upd='sudo apt update -y && sudo apt upgrade -y && sudo apt autopurge -y && rustup update'
        
        # Linux-specific PATH
        export PATH=$PATH:~/.local/bin
        ;;
        
    darwin*)
        # macOS aliases and settings
        alias ls='ls -G'
        alias upd='brew update && brew outdated && brew upgrade && brew cleanup'
        
        # macOS-specific PATH and environment
        export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
        export CPPFLAGS=-I/opt/homebrew/opt/openjdk/include
        eval "$(/opt/homebrew/bin/brew shellenv)"
        ;;
esac

# -----------------------------------------------------------------------------
# Aliases
# -----------------------------------------------------------------------------

# File listing aliases
alias ll='ls -lh'
alias la='ls -lha'
alias l='ls -CF'

# Sudo aliases
alias _='sudo'
alias _i='sudo -i'
alias please='sudo'
alias fucking='sudo'

# Navigation aliases
alias cdh='cd ~/'
alias cddc='cd ~/Documents'
alias cddw='cd ~/Downloads'
alias cdpic='cd ~/Pictures'

# System aliases
alias cacheclear='sudo sysctl -w vm.drop_caches=3'
alias kill3000='kill -9 $(lsof -t -i:3000)'
alias uefiin='sudo systemctl reboot --firmware-setup'
alias biosin='sudo systemctl reboot --firmware-setup'

# Development aliases
alias dockere='docker exec -u 0 -it'
alias cjp='convert `ls -v`'
alias cpn='convert `ls -v`'

# -----------------------------------------------------------------------------
# Development Environment Setup
# -----------------------------------------------------------------------------

# Node.js environment (NVM)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Auto-switch Node version based on .nvmrc
if [[ -a ".nvmrc" ]]; then
    nvm use
fi

# Deno environment
export DVM_DIR="$HOME/.dvm"
export PATH="$DVM_DIR/bin:$PATH"
export PATH="/home/amkkr/.deno/bin:$PATH"

# Bun environment
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
[ -s "/Users/amkkr/.bun/_bun" ] && source "/Users/amkkr/.bun/_bun"

# Rust environment
. "$HOME/.cargo/env"  

# Go environment
export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOBIN

# -----------------------------------------------------------------------------
# Tool-Specific Configuration
# -----------------------------------------------------------------------------

# FZF fuzzy finder
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Bat theme
export BAT_THEME=gruvbox-dark

# Google Cloud SDK
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then 
    . "$HOME/google-cloud-sdk/path.zsh.inc"
fi
if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then 
    . "$HOME/google-cloud-sdk/completion.zsh.inc"
fi

# Direnv integration
eval "$(direnv hook zsh)"

# Tab completion for packages
[[ -f ~/.config/tabtab/zsh/__tabtab.zsh ]] && . ~/.config/tabtab/zsh/__tabtab.zsh || true

# 1Password CLI (commented out)
# eval $(op signin)

# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=(/Users/yakuratenshin/.docker/completions $fpath)
autoload -Uz compinit
compinit
# End of Docker CLI completions

. "$HOME/.local/bin/env"
# Local Install Claude Code
alias claude="~/.claude/local/claude"
