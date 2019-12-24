#!/bin/bash

## APT Packages
echo "[SCRIPT] Update and Install APT packages"
sudo apt update && sudo apt upgrade -y
sudo apt install git zsh htop flameshot fonts-font-awesome vim  fonts-firacode tmux build-essential cmake python3-dev
wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash

echo "[SCRIPT] Install Gogh Themes for Ubuntu Terminal"
read -p "Install SPACEGRAY || Press enter to continue"
bash -c  "$(wget -qO- https://git.io/vQgMr)"

## Snaps 
echo "[SCRIPT] Installing snaps"
snap install spotify --classic
snap install slack --classic
snap install postman
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
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +PlugInstall +qall

git clone https://github.com/powerline/fonts.git --depth=1
cd fonts && ./install.sh && cd .. && rm -rf fonts/

echo "[SCRIPT] Install VSCode Editor"
sudo dpkg -i | wget https://code.visualstudio.com/docs/?dv=linux64_deb

echo "[SCRIPT] Installing ZSH and desired plugins."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

echo "[SCRIPT] Starting Tmux and running plugin installation"
read -p "After entering tmux, press prefix + I to install everything. Now press enter to continue"
tmux source ~/.tmux.conf 
