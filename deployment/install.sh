#!/bin/bash

CURRENT_OS=""

if [[ "$OSTYPE" == "linux-gnu" ]]; then
    CURRENT_DISTRO=$(awk -F= '/^NAME/{print $2}' /etc/os-release)
    if [[ "$CURRENT_DISTRO" == "\"Ubuntu\"" ]]; then
        export CURRENT_OS=ubuntu
    else
        echo "Current distro $CURRENT_DISTRO is not supported"
        exit 1
    fi
elif [[ "$OSTYPE" == "darwin"* ]]; then
    export CURRENT_OS=macos
else
    echo "Current OS: $OSTYPE is not supported"
    exit 1
fi

echo $CURRENT_OS

cd
export SCRIPT_PATH=${PWD}/scripts

