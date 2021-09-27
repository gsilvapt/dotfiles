#!/usr/bin bash

echo "[SCRIPT] UPDATES"
sudo apt update
sudo apt install kali-desktop-gnome tmux terminator python-is-python3

echo "[SCRIPT] REMOVE UNUSED"
sudo apt remove --purge xfce4* burpsuite

echo "[SCRIPT] INSTALL MY TOOLS"
wget https://portswigger.net/burp/releases/community/latest -o burpsuite
sudo sh burpsuite
rm burpsuite

printf "%s\n" "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-ce-archive-keyring.gpg] https://download.docker.com/linux/debian buster stable" | sudo tee /etc/apt/sources.list.d/docker-ce.list
curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/docker-ce-archive-keyring.gpg
sudo apt update && sudo apt install docker-ce docker-ce-cli containerd.io

wget https://golang.org/dl/go1.16.6.linux-amd64.tar.gz
rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.16.6.linux-amd64.tar.gz
echo "export PATH=$PATH:/usr/local/go/bin" >> ~/.bashrc
source ~/.bashrc
go get -u github.com/tomnomnom/httprobe

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

echo "[SCRIPT] MOVE CONFIGS"
cp init.vim ~/.vimrc
cp .tmux.conf ~/.tmux.conf
 
echo "[SCRIPT] ADD ALIASES"
echo "alias rustscan='docker run -it --rm --name rustscan rustscan/rustscan:latest'" >> ~/.zshrc
echo "alias wpscan='docker run -it --rm --name wpscan wpscanteam/wpscan'" >> ~/.zshrc
