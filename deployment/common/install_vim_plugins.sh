#!/bin/sh


nvim +PluginInstall +qall

#YouCompleteMe
cd ~/.vim/bundle/YouCompleteMe
python3 ./install.py --all
python3 ./install.py --clangd-completer
cd

#Command-T - maybe to replace with fzf
