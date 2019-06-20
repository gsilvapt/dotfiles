#!/bin/bash

## APT Packages
echo "Installing APT packages"
sudo apt update
sudo apt install git htop flameshot vim tmux
sudo apt install build-essential cmake python3-dev fish
wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash

## Snaps 
echo "Installing snaps"
sudo snap install spotify --classic
sudo snap install discord --classic
sudo snap install slack --classic
sudo snap install postman

## FZF
echo "Installing FZF"
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

echo "Moving config files before installing things"
cp .vimrc ~/.vimrc
cp .zshrc ~/.zshrc
cp .gitconfig ~/.config

echo "Installing oh-my-fish shell"
curl -L https://get.oh-my.fish | fish
omf install agnoster
omf theme agnoster

echo "Install vim-plug and other related utilities"
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +PlugInstall +qall

git clone https://github.com/powerline/fonts.git --depth=1
cd fonts && ./install.sh && cd .. && rm -rf fonts/

echo "Installing VSCode"
sudo dpkg -i | wgezshht https://code.visualstudio.com/docs/?dv=linux64_deb
