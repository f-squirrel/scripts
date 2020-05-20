#!/bin/bash

gvim() {
    ${NVIM_QT_PATH} "$@" &
}

alias gvim=gvim "$@"
alias gview='gvim "$@" -- -R'
