#! /bin/zsh

# Delete default .bash file
(rm -rf ~/.bash*)
(rm -rf ~/.zsh*)

# unset ~/.zshrc
ln -s `pwd`/.zshrc ~/
rm -rf ~/.gitconfig
echo "[include]" >> ~/.gitconfig
echo "path = `pwd`/.gitconfig"  >> ~/.gitconfig

# set NeoVim Configs
rm -rf ~/.config/nvim
# unset ~/.config/nvim
mkdir -p ~/.config
ln -s `pwd`/nvim ~/.config/nvim

case ${OSTYPE} in
    linux*)
        # set warp-terminal config files
        if [[ -d $HOME/.config ]] then
          ln -s `pwd`/warp-terminal ~/.config/
        else
          mkdir -p $HOME/.config
          ln -s `pwd`/warp-terminal ~/.config/
        fi
        ;;
        
    darwin*)
        # set warp-terminal config files
        if [[ -d $HOME/.warp ]] then
          rm -r $HOME/.warp/*
          ln -s `pwd`/darwin-mac.yaml ~/.warp/keybindings.yaml
        else
          mkdir -p $HOME/.warp
          ln -s `pwd`/darwin-mac.yaml ~/.warp/keybindings.yaml
        fi
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


curl -fLo ~/.local/share/nvim/site/pack/jetpack/opt/vim-jetpack/plugin/jetpack.vim --create-dirs https://raw.githubusercontent.com/tani/vim-jetpack/master/plugin/jetpack.vim


# dvm install
curl -fsSL https://dvm.deno.dev | sh

source ~/.zshrc
