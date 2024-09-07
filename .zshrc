autoload colors && colors
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey  "^[[H"   beginning-of-line
bindkey  "^[[F"   end-of-line
bindkey  "^[[3~"  delete-char
# End of lines configured by zsh-newuser-install

# ps1 and git prompt
source ~/.zsh/git-prompt.sh
fpath=(~/.zsh $fpath)
zstyle ':completion:*:*:git:*' script ~/.zsh/git-completion.bash
autoload -Uz compinit && compinit -u

# prompt show option
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWUPSTREAM=auto
GIT_PS1_SHOWCOLORHINTS=true

if [ ${UID} -eq 0 ]; then
  ISROOT="%K{red}%F{black}ROOT %k%f"
fi

RPROMPT="${ISROOT}"
setopt PROMPT_SUBST ; PS1='[%B%F{green}%n%f%b@%B%F{green}%m%f:%F{blue}%~%f%b] $(__git_ps1 "(%s)")'$'\n'

# aliases

case ${OSTYPE} in
    linux*)
        alias ls='ls --color=auto'
        # alias upd='sudo apt update -y && sudo apt upgrade -y && sudo apt autopurge -y && sudo snap refresh'
        # alias upd='sudo dnf upgrade -y && sudo dnf autoremove'
        alias upd='sudo zypper ref && sudo zypper up -y'
        export PATH=$PATH:~/.local/bin
        setopt PROMPT_SUBST ; PS1='[%B%F{green}%n%f%b@%B%F{green}%m%f:%F{blue}%~%f%b] $(__git_ps1 "(%s)")'$'\n'

        ;;
    darwin*)
        alias ls='ls -G'
        alias upd='brew update && brew outdated && brew upgrade && brew cleanup'
        setopt PROMPT_SUBST ; PS1='[%B%F{green}%n%f%b@%B%F{green}%m%f:%F{blue}%~%f%b] $(__git_ps1 "(%s)")'
        PROMPT="${PROMPT}"$'\n'
        # npm and node version manager
        export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
        export CPPFLAGS=-I/opt/homebrew/opt/openjdk/include
        eval "$(/opt/homebrew/bin/brew shellenv)"

        ;;
esac

# some more ls aliases
alias ll='ls -lh'
alias la='ls -lha'
alias l='ls -CF'
alias _='sudo'
alias _i='sudo -i'
alias please='sudo'
alias fucking='sudo'

# cd aliases
alias cdh='cd ~/'
alias cddc='cd ~/Documents'
alias cddw='cd ~/Downloads'
alias cdpic='cd ~/Pictures'

alias cacheclear='sudo sysctl -w vm.drop_caches=3'
alias cjp='convert `ls -v`'
alias cpn='convert `ls -v`'

alias kill3000='kill -9 $(lsof -t -i:3000)'
alias uefiin='sudo systemctl reboot --firmware-setup'
alias biosin='sudo systemctl reboot --firmware-setup'

# docker
alias dockere='docker exec -u 0 -it'


. "$HOME/.cargo/env"

# aqua path module version manager
export PATH=$PATH:"/Users/silver/.local/share/aquaproj-aqua/bin"

export PATH="$HOME/Library/platform-tools:$PATH"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOBIN
export BAT_THEME=gruvbox-dark

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

if [[ -a ".nvmrc" ]]; then
    nvm use
fi

# tabtab source for packages
# uninstall by removing these lines
[[ -f ~/.config/tabtab/zsh/__tabtab.zsh ]] && . ~/.config/tabtab/zsh/__tabtab.zsh || true

export DVM_DIR="$HOME/.dvm"
export PATH="$DVM_DIR/bin:$PATH"

# eval $(op signin)

eval "$(direnv hook zsh)"

# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/google-cloud-sdk/path.zsh.inc"; fi

# The next line enables shell command completion for gcloud.
if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/google-cloud-sdk/completion.zsh.inc"; fi

