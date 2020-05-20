#!/bin/bash

export DEBIAN_FRONTEND=noninteractive
echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
apt-get update && apt-get install -y --no-install-recommends apt-utils

apt-get update && apt-get -y -q install \
    apt-utils \
    autoconf \
    automake \
    build-essential \
    clang \
    cmake \
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

echo "Installed basic tools"

cd
git clone https://github.com/f-squirrel/scripts.git
# TODO: remove after updated
echo "SCRIPT PATH:" ${SCRIPT_PATH}
cd ${SCRIPT_PATH}
git checkout ${TARGET_BRANCH}
cd ..

bash ${SCRIPT_PATH}/deployment/ubuntu/nvim_core.sh
#TODO: add condition for GUI!
bash ${SCRIPT_PATH}/deployment/ubuntu/fonts.sh

bash ${SCRIPT_PATH}/deployment/common/setup_links.sh
bash ${SCRIPT_PATH}/deployment/common/setup_zshrc.sh
bash ${SCRIPT_PATH}/deployment/common/setup_custom_script_helpers.sh

# fzf needs to be installed after zsh because it patches .zshrc
bash ${SCRIPT_PATH}/deployment/ubuntu/build_tools.sh
bash ${SCRIPT_PATH}/deployment/common/install_vim_plugins.sh

echo "installation completed"
