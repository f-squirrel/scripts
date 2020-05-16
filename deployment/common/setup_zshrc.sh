#!/bin/bash

cd
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
echo "Installed zsh: " $?

sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="miloshadzic"/' ${HOME}/.zshrc

# language setup
echo 'export LANG=en_US.UTF-8' >> ${HOME}/.zshrc
echo 'export LC_CTYPE=en_US.UTF-8' >> ${HOME}/.zshrc
echo 'export LC_ALL=en_US.UTF-8' >> ${HOME}/.zshrc

echo "export EDITOR='nvim'" >> ${HOME}/.zshrc

# to show user when in ssh
echo 'DEFAULT_USER=$USER' >> ${HOME}/.zshrc

#Setup zshrc
if [[ -n $LOCAL_INSTALLATION ]]; then
    echo 'export REMOTE_DEV_USER=<user name for remote dev station>' >> ${HOME}/.zshrc
    echo 'export REMOTE_DEV_SERVER=<IP>' >> ${HOME}/.zshrc
    echo 'export NVIM_QT_PATH="<path neovim-qt>"' >> ${HOME}/.zshrc
    echo 'export MIN_PORT=7770' >> ${HOME}/.zshrc
    echo 'export MAX_PORT=7790' >> ${HOME}/.zshrc
    echo 'alias gvim="$NVIM_QT_PATH &"' >> ${HOME}/.zshrc

    echo "Please fill the env variable added to ${HOME}/.zshrc"
fi
chsh -s $(which zsh)
