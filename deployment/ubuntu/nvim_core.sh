#!/bin/sh

set -eo pipefail

mkdir -p ${HOME}/Applications
cd ${HOME}/Applications
# apt-get provides a vry old versin of nvim which does not support --listen
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage

#if [[ -n $LOCAL_INSTALLATION ]]; then
    CUSTOM_NVIM_PATH=${HOME}/Applications/nvim.appimage
    # Set the above with the correct path, then run the rest of the commands:
    set -u
    # Need this one to make view work
    update-alternatives --install /usr/bin/nvim nvim "${CUSTOM_NVIM_PATH}" 110
    update-alternatives --install /usr/bin/ex ex "${CUSTOM_NVIM_PATH}" 110
    update-alternatives --install /usr/bin/vi vi "${CUSTOM_NVIM_PATH}" 110
    update-alternatives --install /usr/bin/view view "${CUSTOM_NVIM_PATH}" 110
    update-alternatives --install /usr/bin/vim vim "${CUSTOM_NVIM_PATH}" 110
    update-alternatives --install /usr/bin/vimdiff vimdiff "${CUSTOM_NVIM_PATH}" 110
#else
    # --appimage-extract is needed because it is a mess to run FUSE at docker
    #./nvim.appimage --appimage-extract
    #mv ${HOME}/squashfs-root ${HOME}/.nvim_install_dir
    ## Link the binary so all the dependency will be able to find it
    #ln -sf ${HOME}/.nvim_install_dir/usr/bin/nvim /usr/bin/nvim
    #rm nvim.appimage
#fi

cd

#python-provider
python3 -m pip install --user --upgrade pynvim

printf "Finished nvim core setup\n"
