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

# prompt show option
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWUPSTREAM=auto
GIT_PS1_SHOWCOLORHINTS=true

# ps1 and git prompt
fpath=(~/.zsh $fpath)
source ~/.git-prompt.sh

if [ ${UID} -eq 0 ]; then
  ISROOT="%K{red}%F{black}ROOT %k%f"
fi

RPROMPT="${ISROOT}"
setopt PROMPT_SUBST ; PS1='[%B%F{green}%n%f%b@%B%F{green}%m%f:%F{blue}%~%f%b]
 $(__git_ps1 " (%s)")$>'

# aliases

# update
alias upd='sudo dnf upgrade -y && sudo dnf autoremove'
# alias upd='sudo apt update -y && sudo apt upgrade -y && sudo apt autopurge -y && sudo snap refresh'
# alias upd='sudo zypper ref && sudo zypper dup'

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

eval "$(direnv hook zsh)"

# nvm settings
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export nvmrc=~/.nvm/nvm.sh
eval "$(direnv hook bash)"

# dvm settings
export PATH=$PATH:~/.dvm/bin

. "$HOME/.cargo/env"

[[ -s "/home/o-gane/.gvm/scripts/gvm" ]] && source "/home/o-gane/.gvm/scripts/gvm"
export DVM_DIR="/Users/silver/.dvm"
export PATH="$DVM_DIR/bin:$PATH"
