#! /usr/bin/bash

# vscode install
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo zypper addrepo https://packages.microsoft.com/yumrepos/vscode vscode
sudo zypper refresh
sudo zypper install code-insiders

# git settings
sudo zypper in git
git config --global user.name AmanoKokoro
git config --global user.email 55781271+AmanoKokoro@users.noreply.github.com

ssh-keygen -t ed25519 -C $(git config --global user.email)
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

git clone git@github.com:AmanoKokoro/My_neovim_settings.git
