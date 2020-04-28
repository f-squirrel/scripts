#!/bin/bash

VIM_DIR_PATH=~/.vim/
NVIM_CONFIG_PATH=~/.config/nvim/

#vim
ln -sf ${PWD}/dotfiles/vim/.vimrc ${HOME}/.vimrc
ln -sf ${PWD}/dotfiles/vim/.gvimrc ~/.gvimrc

# nvim
mkdir -p ${NVIM_CONFIG_PATH}
ln -sf ${PWD}/dotfiles/vim/init.vim ${NVIM_CONFIG_PATH}
ln -sf ${PWD}/dotfiles/vim/ginit.vim ${NVIM_CONFIG_PATH}

# code style
ln -sf ${PWD}/dotfiles/vim/code_style/.default_code_style.vim ${VIM_DIR_PATH}/.code_style.vim
printf "Installed default code style to ~/.vim/.code_style.vim\n"
printf "Replace the symlink if needed!\n"

# YCM extras
ln -sf ${PWD}/dotfiles/vim/ycm/.ycm_extra_conf.py ~/.ycm_extra_conf.py
printf "Installed YCM extras to ${HOME}\n"
printf "Replace the symlink if needed!\n"

# tmux
ln -sf ${PWD}/dotfiles/.tmux.conf ~/.tmux.conf
tmux source-file ~/.tmux.conf

ln -sf {PWD}/dotfiles/git/gitconfig ~/.gitconfig
