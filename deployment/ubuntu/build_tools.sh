#!/bin/sh

set -eo pipefail

#TODO: Consider installing it via VimPlug
cd
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# To search for hidden files
echo "export FZF_DEFAULT_COMMAND='rg --hidden -l \"\" '" >> ${HOME}/.zshrc
echo "export FZF_CTRL_T_COMMAND='rg --hidden -l \"\" '" >> ${HOME}/.zshrc

printf "Finished building tools!\n"
