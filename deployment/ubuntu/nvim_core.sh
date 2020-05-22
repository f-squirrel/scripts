#!/bin/bash

cd
# apt-get provides a vry old versin of nvim which does not support --listen
curl -LO https://github.com/neovim/neovim/releases/download/stable/nvim.appimage
chmod u+x nvim.appimage

if [[ -n $LOCAL_INSTALLATION ]]; then
    ./nvim.appimage
else
    # --appimage-extract is needed because it is a mess to run FUSE at docker
    ./nvim.appimage --appimage-extract
    mv ${HOME}/squashfs-root ${HOME}/.nvim_install_dir
    # Link the binary so all the dependency will be able to find it
    ln -s ${HOME}/.nvim_install_dir/usr/bin/nvim /usr/bin/nvim
fi

rm nvim.appimage

#python-provider
python3 -m pip install --user --upgrade pynvim

printf "Finished nvim core setup\n"
