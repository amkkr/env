#! /usr/bin/bash

# vscode install
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo zypper addrepo https://packages.microsoft.com/yumrepos/vscode vscode
sudo zypper refresh
sudo zypper install code-insiders

# git settings
sudo zypper in git
git config --global user.name
git config --global user.email 

ssh-keygen -t ed25519 -C $(git config --global user.email)
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

git clone git@github.com:AmanoKokoro/My_neovim_settings.git ~/.config/nvim

#fzf get
if [ ! -e ~/.cache/fzf ]; then
    git clone https://github.com/junegunn/fzf "$XDG_CACHE_HOME/fzf"
    $XDG_CACHE_HOME/fzf/install --xdg --no-key-bindings --completion --no-update-rc
fi

#git prompt get
if [ ! -f ~/.git-completion.bash ] || [ ! ~/.git-prompt.sh ]; then
    wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -O ~/.git-completion.bash
    chmod a+x ~/.git-completion.bash

    wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh -O ~/.git-prompt.sh
    chmod a+x ~/.git-prompt.sh
fi

#vim-plug get

if [ ! -e ~/.local/share/nvim/site/autoload/plug.vim ]; then
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
fi


cp ./.bashrc ~/.bashrc
