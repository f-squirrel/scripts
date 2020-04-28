#!/bin/bash

apt-get update && apt-get -y install \
    autoconf \
    automake \
    build-essential \
    clang \
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
    wget \
    zsh

echo "Installed basic tools"

bash ./ubuntu/nvim_core.sh
bash ./ubuntu/fonts.sh
bash ./ubuntu/build_tools.sh
bash ./install_vim_plugins.sh
