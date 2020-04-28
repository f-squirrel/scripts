#!/bin/bash

apt-get update && apt-get -y install \
    neovim \

#python-provider
python3 -m pip install --user --upgrade pynvim
