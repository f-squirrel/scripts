#!/bin/bash

gvim_helper() {
    nohup ${NVIM_QT_PATH} "$@" 2> /dev/null # & disown
}

alias gvim='gvim_helper "$@"'
alias gview='gvim "$@" -- -R'
alias gvimdiff='${NVIM_QT_PATH} "$@" -- -d'
