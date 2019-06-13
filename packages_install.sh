#!/bin/bash

## APT Packages
echo "[SCRIPT] Update and Install APT packages"
sudo apt update && sudo apt upgrade -y
sudo apt install git zsh htop terminator flameshot fonts-font-awesome vim  fonts-firacode

echo "[SCRIPT] Install Gogh Themes for Ubuntu Terminal"
read -p "Papercolor Light || Press enter to continue"
bash -c  "$(wget -qO- https://git.io/vQgMr)"

## Snaps 
echo "[SCRIPT] Installing snaps"
sudo snap install spotify --classic
sudo snap install postman

## FZF
echo "[SCRIPT] Installing FZF"
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

echo "[SCRIPT] Moving config files before installing things"
cp .vimrc ~/.vimrc
cp .zshrc ~/.zshrc
cp .gitconfig ~/.config

echo "[SCRIPT] Installing Vim Vundle and custom Plugins"
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

echo "[SCRIPT] Install Code Editors - [VSCode]"
sudo dpkg -i | wget https://code.visualstudio.com/docs/?dv=linux64_deb

echo "[SCRIPT] Installing ZSH and moving zsh config."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
