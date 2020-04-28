#!/bin/bash

export DEBIAN_FRONTEND=noninteractive
echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
apt-get update && apt-get install -y --no-install-recommends apt-utils

apt-get update && apt-get -y -q install \
    dialog \
    apt-utils \
    autoconf \
    automake \
    build-essential \
    clang \
    cmake \
    curl \
    g++ \
    git \
    openssh-server \
    pkg-config \
    protobuf-compiler \
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
git checkout new_layout
cd ..

bash ${SCRIPT_PATH}/deployment/ubuntu/nvim_core.sh
#TODO: add condition for GUI!
bash ${SCRIPT_PATH}/deployment/ubuntu/fonts.sh
mkdir -p ~/.vim/bundle/
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
bash ${SCRIPT_PATH}/deployment/common/install_vim_plugins.sh

bash ${SCRIPT_PATH}/deployment/common/setup_links.sh
bash ${SCRIPT_PATH}/deployment/common/setup_zshrc.sh
# fzf needs to be installed after zsh
bash ${SCRIPT_PATH}/deployment/ubuntu/build_tools.sh
bash ${SCRIPT_PATH}/deployment/common/install_vim_plugins.sh
