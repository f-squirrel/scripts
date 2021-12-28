#!/bin/sh

set -eo pipefail

printf "Started zshrc setup!\n"
# Install Vim-Plug
curl -sfLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "Installed Vim-Plug"

#https://github.com/junegunn/vim-plug/wiki/tips#install-plugins-on-the-command-line
nvim -es -u ~/.config/nvim/init.vim -i NONE -c "PlugInstall" -c "qa"
echo "Installed nvim plugins"

pip3 install certifi
export PYTHONHTTPSVERIFY=0
# YouCompleteMe for some reason Vim-PLug returns exit 1 when install automatically
cd ${HOME}/.vim/plugged/YouCompleteMe
python3 ./install.py --clangd-completer --rust-completer --force-sudo
cd ${HOME}

#Command-T - maybe to replace with fzf
printf "Finished plugin setup!\n"
