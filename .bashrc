# =============================================================================
# Bash Configuration for Git Bash (Windows)
# =============================================================================

# -----------------------------------------------------------------------------
# Basic Configuration
# -----------------------------------------------------------------------------

# History configuration
HISTFILE=~/.bash_history
HISTSIZE=1000
HISTFILESIZE=2000

# -----------------------------------------------------------------------------
# Git Prompt (Git Bash has git-prompt.sh built-in)
# -----------------------------------------------------------------------------

# Load git-prompt.sh
source "/c/Program Files/Git/mingw64/share/git/completion/git-prompt.sh"

GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWUPSTREAM=auto
GIT_PS1_SHOWCOLORHINTS=true

# Prompt configuration (use PROMPT_COMMAND for git prompt)
PROMPT_COMMAND='__git_ps1 "[\[\e[1;32m\]\u\[\e[0m\]@\[\e[1;32m\]\h\[\e[0m\]:\[\e[34m\]\w\[\e[0m\]]" "\n"'

# -----------------------------------------------------------------------------
# Aliases
# -----------------------------------------------------------------------------

# File listing aliases
alias ls='ls --color=auto'
alias ll='ls -lh'
alias la='ls -lha'
alias l='ls -CF'

# Sudo aliases (not applicable on Windows Git Bash)
# alias _='sudo'
# alias _i='sudo -i'
# alias please='sudo'
# alias fucking='sudo'

# Navigation aliases
alias cdh='cd ~/'
alias cddc='cd ~/Documents'
alias cddw='cd ~/Downloads'
alias cdpic='cd ~/Pictures'

# Development aliases
alias dockere='docker exec -u 0 -it'

# -----------------------------------------------------------------------------
# Development Environment Setup
# -----------------------------------------------------------------------------

# Node.js environment (NVM for Windows uses nvm-windows, no sourcing needed)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Deno environment
export PATH="$HOME/.deno/bin:$PATH"

# Bun environment
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Rust environment
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

# Go environment
export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOBIN

# -----------------------------------------------------------------------------
# Tool-Specific Configuration
# -----------------------------------------------------------------------------

# Bat theme
export BAT_THEME=gruvbox-dark

# Local Install Claude Code
export PATH="$HOME/.claude/local:$PATH"
