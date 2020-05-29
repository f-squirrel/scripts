#!/bin/bash

gvim_helper() {
    ${NVIM_QT_PATH} "$@" & disown
}

alias gvim=gvim_helper "$@"
alias gview='gvim "$@" -- -R'
