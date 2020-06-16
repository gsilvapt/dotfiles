FROM ubuntu:latest

ARG DEBIAN_FRONTEND=noninteractive

RUN apt update && \
    apt upgrade -y && \
    apt install -y git vim tmux build-essential cmake python3-dev libcurl4-openssl-dev libssl-dev jq ruby-full libxml2 libxml2-dev libxslt1-dev ruby-dev build-essential libgmp-dev zlib1g-dev build-essential libssl-dev libffi-dev libldns-dev python3-pip git rename make gawk g++ gcc libreadline6-dev libyaml-dev libsqlite3-dev sqlite3 autoconf libgdbm-dev libncurses5-dev automake libtool bison pkg-config ruby ruby-bundler nmap wget && \
    wget https://dl.google.com/go/go1.13.4.linux-amd64.tar.gz && \
    tar -C /usr/local -xzf go1.13.4.linux-amd64.tar.gz

ENV GOROOT /usr/local/go
ENV PATH $GOROOT/bin:$PATH

RUN go version && \
    echo "Installed packages and golang successfully"

RUN mkdir ~/tools/ && cd ~/tools && \
    echo "installing custom tools" && \
    git clone https://github.com/aboul3la/Sublist3r.git && \
    cd Sublist3r* && \
    pip3 install -r requirements.txt && \
    cd ~/tools/ && \
    echo "installed sublister successfully" && \
    git clone https://github.com/maurosoria/dirsearch.git && \
    echo "installed dirsearch successfully" && \
    git clone https://github.com/wpscanteam/wpscan.git && \
    echo "installed wpscan successfully" && \
    git clone --depth 1 https://github.com/sqlmapproject/sqlmap.git sqlmap-dev && \
    echo "installed sqlmap successfully" && \
    git clone https://github.com/guelfoweb/knock.git && \
    echo "installed knock successfully" && \
    git clone https://github.com/blechschmidt/massdns.git && \
    cd ~/tools/massdns && \
    make && \
    echo "installed massdns successfully" && \
    cd ~/tools && \
    git clone https://github.com/yassineaboukir/asnlookup.git && \
    cd ~/tools/asnlookup && \
    pip3 install -r requirements.txt && \
    cd ~/tools/ && \
    echo "installed asnlookup successfully" && \
    go get -u github.com/tomnomnom/httprobe && \
    echo "installed httprobe successfully" && \
    go get github.com/OJ/gobuster && \
    echo "installed gobuster successfully" && \
    git clone https://github.com/danielmiessler/SecLists.git && \
    cd ~/tools/SecLists/Discovery/DNS/ && \
    ##THIS FILE BREAKS MASSDNS AND NEEDS TO BE CLEANED
    cat dns-Jhaddix.txt | head -n -14 > clean-jhaddix-dns.txt && \
    cd ~/tools/ && \
    echo "installed SecLists successfully" 

COPY .min_vimrc ~/.vimrc

CMD ["bash"]
