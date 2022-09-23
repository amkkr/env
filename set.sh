#! /usr/bin/bash

# Delete default .bash file
rm -rf ~/.bash*

ln -s `pwd`/.bashrc ~/
ln -s `pwd`/.bash_aliases ~/
ln -s `pwd`/.gitconfig ~/

# set NeoVim Configs
mkdir -p ~/.config/coc
ln -s `pwd`/nvim ~/.config/nvim
ln -s `pwd`/nvim/configCot ~/.config/nvim/coc

source ~/.bashrc

# fzf get
# if [ ! -e ~/.cache/fzf ]; then
#     git clone https://github.com/junegunn/fzf "$XDG_CACHE_HOME/fzf"
#     $XDG_CACHE_HOME/fzf/install --xdg --no-key-bindings --completion --no-update-rc
# fi

# git prompt get
if [ ! -f ~/.git-completion.bash ] || [ ! ~/.git-prompt.sh ]; then
    wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -O ~/.git-completion.bash
    chmod a+x ~/.git-completion.bash

    wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh -O ~/.git-prompt.sh
    chmod a+x ~/.git-prompt.sh
fi

# nvm install
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

# vim-plug get
sh -c 'curl -fLo "${~/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# deno version manager get
curl -fsSL https://deno.land/x/dvm/install.sh | sh

# Rust get
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source ~/.bashrc
