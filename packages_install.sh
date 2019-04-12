#!/bin/bash

## APT Packages
echo "Installing APT packages"
sudo apt update
sudo apt install git zsh htop terminator flameshot fonts-font-awesome vim 

## Snaps 
echo "Installing snaps"
sudo snap install spotify --classic
sudo snap install postman

## FZF
echo "Installing FZF"
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

echo "Moving config files before installing things"
cp .vimrc ~/.vimrc
cp .zshrc ~/.zshrc
cp .gitconfig ~/.config

echo "Installing Vim Vundle and custom Plugins"
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

echo "Installing ZSH and moving configurations"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

echo "Installing Rust Lang"
curl https://sh.rustup.rs -sSf | sh

sudo dpkg -i | wget https://code.visualstudio.com/docs/?dv=linux64_deb
