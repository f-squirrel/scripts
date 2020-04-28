#!/bin/bash

CURRENT_OS=""

export GUI=""

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
#https://github.com/f-squirrel/scripts.git

apt-get update && apt-get -y install curl
bash -c "$(curl -fsSL https://raw.githubusercontent.com/f-squirrel/scripts/new_layout/deployment/${CURRENT_OS}/install.sh)"
