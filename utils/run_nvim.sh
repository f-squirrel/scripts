#!/bin/bash

gvim() {
    ${NVIM_QT_PATH} "$@" &
}

alias gvim=gvim "$@"
