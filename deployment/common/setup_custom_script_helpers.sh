#!/bin/sh

set -eo pipefail

printf "Started custom script setup!\n"
# files with extention different from .zsh are ignored
ln -sf ${HOME}/scripts/utils/run_nvim.sh ${HOME}/.oh-my-zsh/custom/run_nvim.zsh
ln -sf ${HOME}/scripts/utils/run_nvim_remotely.zsh ${HOME}/.oh-my-zsh/custom/run_nvim_remotely.zsh

ln -sf ${HOME}/scripts/utils/generate_cmake.sh ${HOME}/.oh-my-zsh/custom/generate_cmake.zsh

# csshx for tmux

cd ${HOME} && git clone https://github.com/ggarnier/tmux-csshx.git
printf "Finished custom script setup!\n"
