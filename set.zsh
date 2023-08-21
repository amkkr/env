#! /bin/zsh

# Delete default .bash file
rm -rf ~/.bash*
rm -rf ~/.zsh*

ln -s `pwd`/.zshrc ~/
echo "[include]" >> ~/.gitconfig
echo "    path = `pwd`/.gitconfig"  >> ~/.gitconfig

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
    mkdir ~/.zsh/
    wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -O ~/.zsh/git-completion.bash
    chmod a+x ~/.git-completion.bash

    wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh -O ~/.zsh/git-prompt.sh
    chmod a+x ~/.git-prompt.sh

    mkdir ~/.zsh
    wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.zsh -O ~/.zsh/_git
    chmod a+x ~/.zsh/_git

# nvm install
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | sh


# Rust get
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source "$HOME/.cargo/env"

source ~/.zshrc
