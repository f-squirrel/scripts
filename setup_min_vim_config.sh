#!/bin/env bash

set -e

CURL_FLAGS="--silent --show-error --fail --location"

function install_nvim {
    echo "Installing Neovim"
    nvim_install_path=${HOME}/.local/bin/nvim
    mkdir -p "$(dirname "${nvim_install_path}")"
    curl ${CURL_FLAGS} \
        'https://github.com/neovim/neovim/releases/latest/download/nvim.appimage' \
        --output ${nvim_install_path}
    chmod u+x ${nvim_install_path}
    echo "Neovim installed to ${nvim_install_path}."

    if ! echo ${PATH} | grep "${HOME}\/\.local\/bin" &> /dev/null ; then
        echo "The install dir is not in your PATH, add it to make nvim available"
        exit 1
    fi
    echo "To remove it, simply rm ${nvim_install_path}"
}

function print_help {
    echo "This script installs minimal Vim/Neovim config and creates backup for existing configs"
    echo "Options:"
    echo "--help       - Show help"
    echo "--install    - Install Neovim"
    echo "--insecure   - Tell curl to ignore certificate issues, should not be a problem since the script downloads from Github"
}

function main {
    if [[ "$*" == *"--help"* ]]; then
        print_help
        exit 0
    fi
    if [[ "$*" == *"--insecure"* ]]; then
        echo "insecure"
        CURL_FLAGS="${CURL_FLAGS} --insecure"
    fi
    if [[ "$*" == *"--install"* ]]; then
        install_nvim
    fi

    if command -v nvim &> /dev/null ; then
        echo "Found Neovim"
        config_path="${HOME}/.config/nvim/init.vim"
        mkdir -p "$(dirname "${config_path}")"
    elif command -v vim &> /dev/null ; then
        echo "Found Vim"
        config_path="${HOME}/.vimrc"
    else
        echo "Failed to find Neovim or Vim, please install either of them to continue"
        echo "To install a non-intrusive version of Neovim, run this script with --install"
        exit 1
    fi

    if [ -f "${config_path}" ]; then
        backup_path="${config_path}.$(date --iso-8601=seconds).origin"
        mv "${config_path}" "${backup_path}"
        echo "Created backup for user config in ${backup_path}"
    fi

    curl ${CURL_FLAGS} \
            'https://raw.githubusercontent.com/f-squirrel/scripts/master/dotfiles/vim/minimal.vim' \
         --output \
            "${config_path}"
    echo "Installed config to ${config_path}"

    if [ -z "${backup_path}" ]; then
        echo "In order to remove the settings run:"
        echo "rm ${config_path}"
    else
        echo "In order to restore the original settings run:"
        echo "mv ${backup_path} ${config_path}"
    fi
}

main "$@"
