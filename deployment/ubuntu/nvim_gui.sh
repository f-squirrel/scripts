#!/bin/sh

set -eo pipefail

apt-get update && apt-get -y install \
    neovim-qt

printf "Finished nvim gui setup\n"
