#!/bin/bash

export BRANCH="new_layout"
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

if [[ "$CURRENT_OS" == "ubuntu" ]]; then
    # Vanilla Ubuntu comes without curl
    apt-get update && apt-get -y install curl
fi

bash -c "$(curl -fsSL https://raw.githubusercontent.com/f-squirrel/scripts/${BRANCH}/deployment/${CURRENT_OS}/install.sh)"
