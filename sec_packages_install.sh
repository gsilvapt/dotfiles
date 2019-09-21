#!/bin/bash

## Essential packages
echo "[SCRIPT] Update and Install APT packages"
sudo apt update && sudo apt upgrade -y
sudo apt install git vim tmux build-essential cmake python3-dev

echo "[SCRIPT] Install Gogh Themes for Ubuntu Terminal"
read -p "Install SPACEGRAY || Press enter to continue"
bash -c  "$(wget -qO- https://git.io/vQgMr)"

## Utils needed for pentest
sudo apt install dirbuster gobuster exploitdb nmap

## FZF
echo "[SCRIPT] Installing FZF"
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

echo "[SCRIPT] Moving config files before installing things"
cp .tmux.conf ~/.tmux.conf
cp .vimrc ~/.vimrc
cp .zshrc ~/.zshrc
cp .gitconfig ~/.gitconfig
cp .conkyrc ~/.conkyrc

echo "[SCIRPT] Prepare Nano for all environments"
find /usr/share/nano/ -iname "*.nanorc" -exec echo include {} \; >> ~/.nanorc

echo "[SCRIPT] Installing Vim Vundle and custom Plugins"
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vimcurl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +PlugInstall +qall

git clone https://github.com/powerline/fonts.git --depth=1
cd fonts && ./install.sh && cd .. && rm -rf fonts/

echo "[SCRIPT] Installing ZSH and desired plugins."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

echo "[SCRIPT] Starting Tmux and running plugin installation"
read -p "After entering tmux, press prefix + I to install everything. Now press enter to continue"
tmux source ~/.tmux.conf 