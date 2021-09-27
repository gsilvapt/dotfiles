#!/usr/bin/bash

## APT Packages
echo "[SCRIPT] Update and Install APT packages"
sudo apt update && sudo apt upgrade -y
sudo apt install git zsh htop neovim fonts-firacode terminator build-essential cmake python3-dev flameshot

## FZF
echo "[SCRIPT] Installing FZF"
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

echo "[SCRIPT] Moving config files before installing things"
mkdir ~/.config/nvim/
cp init.vim ~/.config/nvim/init.vim
cp .zshrc ~/.zshrc
cp .zsh_aliases ~/.zsh_aliases
cp .zsh_env ~/.zsh_env
cp .gitconfig ~/.gitconfig
cp .tmux.conf ~/.tmux.conf

echo "[SCRIPT] Installing Vim Vundle and custom Plugins"
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

