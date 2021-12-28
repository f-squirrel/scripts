#!/bin/bash

set -e
set -o pipefail

export DEBIAN_FRONTEND=noninteractive
echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
apt-get update && apt-get install -y --no-install-recommends apt-utils


apt-get update && apt-get -y -q --no-install-recommends install \
    apt-utils \
    autoconf \
    automake \
    build-essential \
    clang-7 \
    curl \
    dialog \
    g++ \
    gdb \
    git \
    iputils-ping \
    net-tools \
    openssh-server \
    pkg-config \
    pyflakes \
    pyflakes3 \
    python \
    python3-setuptools \
    python3 \
    python3-dev \
    python3-pip \
    tmux \
    wget \
    zsh
 
apt-get install -y --reinstall ca-certificates
mkdir -p /usr/local/share/ca-certificates/cacert.org
wget -P /usr/local/share/ca-certificates/cacert.org http://www.cacert.org/certs/root.crt http://www.cacert.org/certs/class3.crt
update-ca-certificates --fresh
export SSL_CERT_DIR=/etc/ssl/certs

#RUN ln -s /usr/bin/clang-7 /usr/bin/clang

# Dirty hack, sometimes base image already has newer cmake installed manually

curl -LO https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/ripgrep_13.0.0_amd64.deb
dpkg -i ripgrep_13.0.0_amd64.deb
rm ripgrep_13.0.0_amd64.deb

if [ ! -f "/usr/bin/cmake" ]; then
    apt-get update && apt-get -y -q install cmake
fi

echo "Installed basic tools"

cd ${HOME}
git clone https://github.com/f-squirrel/scripts.git
cd ${SCRIPT_PATH}
git checkout ${TARGET_BRANCH}
cd ..

#TODO: add condition for GUI!
bash ${SCRIPT_PATH}/deployment/common/fonts.sh

bash ${SCRIPT_PATH}/deployment/common/setup_links.sh
bash ${SCRIPT_PATH}/deployment/common/setup_zshrc.sh
bash ${SCRIPT_PATH}/deployment/common/setup_custom_script_helpers.sh

bash ${SCRIPT_PATH}/deployment/ubuntu/nvim_core.sh
# fzf needs to be installed after zsh because it patches .zshrc
bash ${SCRIPT_PATH}/deployment/ubuntu/build_tools.sh


echo "Configure compiler"
apt-get update && apt-get -y -q --no-install-recommends install \
    software-properties-common

add-apt-repository -y ppa:ubuntu-toolchain-r/test

apt-get update && apt-get -y -q --no-install-recommends install \
    gcc-9 g++-9

# Set Clang 10 as default compiler
update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-9 100
update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-9 100

update-alternatives --install /usr/bin/cc cc /usr/bin/gcc 100
update-alternatives --install /usr/bin/c++ c++ /usr/bin/g++ 100

echo "Configured compiler"

bash ${SCRIPT_PATH}/deployment/common/install_vim_plugins.sh

# Set Clang 7 as default compiler
update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-7 100
update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-7 100

wget --quiet --no-check-certificate https://github.com/sharkdp/bat/releases/download/v0.15.4/bat_0.15.4_amd64.deb
dpkg -i bat_0.15.4_amd64.deb
rm bat_0.15.4_amd64.deb

echo "installation completed"
