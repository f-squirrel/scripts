#!/bin/sh

#set -eo pipefail

# Install Vim-Plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "Installed Vim-Plug"

#https://github.com/junegunn/vim-plug/wiki/tips#install-plugins-on-the-command-line
nvim -es -u ~/.config/nvim/init.vim -i NONE -c "PlugInstall" -c "qa"
echo "Installed nvim plugins"

# YouCompleteMe for some reason Vim-PLug returns exit 1 when install automatically
cd ~/.vim/plugged/YouCompleteMe
python3 ./install.py --all
python3 ./install.py --clangd-completer
cd

#Command-T - maybe to replace with fzf
printf "Finished plugin setup!\n"
