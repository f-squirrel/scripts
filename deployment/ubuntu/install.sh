#!/bin/bash

set -eo pipefail

export DEBIAN_FRONTEND=noninteractive
echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
apt-get update && apt-get install -y --no-install-recommends apt-utils

apt-get update && apt-get -y -q install \
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
    python3 \
    python3-dev \
    python3-pip \
    silversearcher-ag \
    tmux \
    wget \
    zsh

# Set Clang 7 as default compiler
update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-7 100
update-alternatives --install /usr/bin/clang clang /usr/bin/clang-7 100

update-alternatives --install /usr/bin/cc cc /usr/bin/clang 100
update-alternatives --install /usr/bin/c++ c++ /usr/bin/clang++ 100

#RUN ln -s /usr/bin/clang-7 /usr/bin/clang

# Dirty hack, sometimes base image already has newer cmake installed manually
if [ ! -f "/usr/bin/cmake" ]; then
    apt-get update && apt-get -y -q install cmake
fi

echo "Installed basic tools"

cd
git clone https://github.com/f-squirrel/scripts.git
cd ${SCRIPT_PATH}
git checkout ${TARGET_BRANCH}
cd ..

bash ${SCRIPT_PATH}/deployment/ubuntu/nvim_core.sh
#TODO: add condition for GUI!
bash ${SCRIPT_PATH}/deployment/common/fonts.sh

bash ${SCRIPT_PATH}/deployment/common/setup_links.sh
bash ${SCRIPT_PATH}/deployment/common/setup_zshrc.sh
bash ${SCRIPT_PATH}/deployment/common/setup_custom_script_helpers.sh

# fzf needs to be installed after zsh because it patches .zshrc
bash ${SCRIPT_PATH}/deployment/ubuntu/build_tools.sh
bash ${SCRIPT_PATH}/deployment/common/install_vim_plugins.sh

wget --no-check-certificate https://github.com/sharkdp/bat/releases/download/v0.15.4/bat_0.15.4_amd64.deb
dpkg -i bat_0.15.4_amd64.deb
rm bat_0.15.4_amd64.deb

echo "installation completed"
