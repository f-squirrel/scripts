#!/bin/bash

cd ${HOME}

# XCode utils
xcode-select --install

# Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

brew install \
    cmake \
    fzf \
    git \
    python \
    the_silver_searcher \
    tmux \
    wget \
    zsh

cd
git clone https://github.com/f-squirrel/scripts.git
# TODO: remove after updated
echo "SCRIPT PATH:" ${SCRIPT_PATH}
cd ${SCRIPT_PATH}
git checkout ${TARGET_BRANCH}
cd ..


bash ${SCRIPT_PATH}/deployment/macos/nvim_core.sh
bash ${SCRIPT_PATH}/deployment/macos/nvim_gui.sh
bash ${SCRIPT_PATH}/deployment/common/fonts.sh

bash ${SCRIPT_PATH}/deployment/common/setup_links.sh
bash ${SCRIPT_PATH}/deployment/common/setup_zshrc.sh
bash ${SCRIPT_PATH}/deployment/common/setup_custom_script_helpers.sh

bash ${SCRIPT_PATH}/deployment/common/install_vim_plugins.sh
