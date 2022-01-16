#!/bin/bash

gvim_helper() {
    nohup ${NVIM_QT_PATH} "$@" >/dev/null 2>&1 # & disown
}

alias gvim='gvim_helper "$@"'
alias gview='gvim "$@" -- -R'
alias gvimdiff='${NVIM_QT_PATH} "$@" -- -d'
