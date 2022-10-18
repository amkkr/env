#! /bin/zsh

# Delete default .bash file
rm -rf ~/.zsh*

ln -s `pwd`/.zshrc ~/
cat ./.gitconfig >> ~/.gitconfig

# set NeoVim Configs
ln -s `pwd`/nvim ~/.config/nvim

case ${OSTYPE} in
    linux*)
        mkdir -p ~/.local/share/applications/
        ln -s `pwd`/desktop/ ~/.local/share/applications
        ;;
esac

source ~/.zshrc

# git prompt get
if [ ! -e ~/.git-completion.bash ] || [ ! -e ~/.git-prompt.sh ]; then
    wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -O ~/.git-completion.bash
    chmod a+x ~/.git-completion.bash

    wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh -O ~/.git-prompt.sh
    chmod a+x ~/.git-prompt.sh

    mkdir ~/.zsh
    wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.zsh -O ~/.zsh/_git
    chmod a+x ~/.zsh/_git
fi

# nvm install
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | sh

# deno version manager get
curl -fsSL https://deno.land/x/dvm/install.sh | sh

# Rust get
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

source ~/.zshrc
