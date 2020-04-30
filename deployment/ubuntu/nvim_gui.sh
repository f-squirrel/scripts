#!/bin/sh

apt-get update && apt-get -y install \
    neovim-qt

printf "Finished nvim gui setup\n"
