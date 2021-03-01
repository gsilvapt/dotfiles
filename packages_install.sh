#!/bin/bash

## APT Packages
echo "[SCRIPT] Update and Install APT packages"
sudo apt update && sudo apt upgrade -y
sudo apt install git zsh htop neovim fonts-firacode terminator build-essential cmake python3-dev flameshot

## FZF
echo "[SCRIPT] Installing FZF"
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

echo "[SCRIPT] Moving config files before installing things"
mkdir ~/.config.nvim/
cp init.vim ~/.config/nvim/init.vim
cp .zshrc ~/.zshrc
cp .gitconfig ~/.gitconfig

echo "[SCIRPT] Prepare Nano for all environments"
find /usr/share/nano/ -iname "*.nanorc" -exec echo include {} \; >> ~/.nanorc

echo "[SCRIPT] Installing Vim Vundle and custom Plugins"
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

echo "[SCRIPT] Fonts & Stuff" 
wget https://download.jetbrains.com/fonts/JetBrainsMono-1.0.3.zip
unzip JetBrainsMono-1.0.3.zip
mv JetBrainsMono-* ~/.local/share/fonts/

echo "[SCRIPT] Installing ZSH and desired plugins."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
