#!/usr/bin bash

echo "[SCRIPT] UPDATES"
sudo apt update && sudo apt upgrade -y
sudo apt install terminator zsh neovim htop build-essentials cmake python3-dev apt-transport-https \
    ca-certificates curl gnupg lsb-release xclip john openjdk-17-jdk nmap

echo "[SCRIPT] REMOVE UNUSED"
sudo apt autoremote && sudo apt autoclean

echo "[SCRIPT] INSTALL MY SEC TOOLS"
wget https://portswigger.net/burp//burp/releases/download?product=community&version=2021.8.4&type=Linux -o burpsuite
sudo sh burpsuite
rm burpsuite

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update && sudo apt install docker-ce docker-ce-cli containerd.io
sudo usermod -aG docker $USER

wget https://golang.org/dl/go1.17.2.linux-amd64.tar.gz
rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.17.2.linux-amd64.tar.gz
echo "export PATH=$PATH:/usr/local/go/bin" >> ~/.bashrc
source ~/.bashrc
go get -u github.com/tomnomnom/httprobe
# TODO: Move to docker container aliases.
go install github.com/OJ/gobuster/v3@latest
go install github.com/OWASP/Amass/v3@latest

curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > msfinstall && \
  chmod 755 msfinstall && \
  ./msfinstall

git clone https://github.com/radareorg/radare2
radare2/sys/install.sh

wget https://github.com/NationalSecurityAgency/ghidra/releases/download/Ghidra_10.0.4_build/ghidra_10.0.4_PUBLIC_20210928.zip
unzip ghidra_10.0.4_PUBLIC_20210928.zip ~/ghidra_10.0.4/
git clone https://github.com/danielmiessler/SecLists.git ~/seclists


echo "[SCRIPT] Moving config files before installing things"
mkdir ~/.config/nvim/
cp init.vim ~/.config/nvim/init.vim
cp .zsh_aliases ~/.zsh_aliases
cp .zsh_env ~/.zsh_env

echo "[SCRIPT] Installing Vim Vundle and custom Plugins"
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

echo "[SCRIPT] ADD ALIASES"
echo "alias rustscan='docker run -it --rm --name rustscan rustscan/rustscan:latest'" >> ~/.zshrc
echo "alias wpscan='docker run -it --rm --name wpscan wpscanteam/wpscan'" >> ~/.zshrc
echo "alias sqlmap='python ~/tools/sqlmap-dev/'"
