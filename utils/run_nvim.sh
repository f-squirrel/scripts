#!/bin/bash

gvim() {
    ${NVIM_QT_PATH} "$@" & disown
}

alias gvim=gvim "$@"
alias gview='gvim "$@" -- -R'
