#!/bin/bash

cd
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="miloshadzic"/' ${HOME}/.zshrc

# language setup
echo 'export LANG=en_US.UTF-8' >> ${HOME}/.zshrc
echo 'export LC_CTYPE=en_US.UTF-8' >> ${HOME}/.zshrc
echo 'export LC_ALL=en_US.UTF-8' >> ${HOME}/.zshrc

echo "export EDITOR='nvim'" >> ${HOME}/.zshrc

# to show user when in ssh
echo 'DEFAULT_USER=$USER' >> ${HOME}/.zshrc
