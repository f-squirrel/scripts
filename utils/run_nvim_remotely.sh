#!/bin/bash

# exit when any command fails
set -e

source nvim_vars.sh

MIN_PORT=7770
MAX_PORT=7790

help() {
    echo "Description:"
    echo "The script launches nvim remotely and neovim-qt locally that connects to the remote instance"
    echo "The script first finds a free port at the remote and runs 'nvim --listen <ip>:<free port> --headless'"
    echo "Then it runs 'neovim-qt --server <ip>:<free port>' that connects to the remote session"
    echo ""
    echo "Usage:"
    echo "run_nvim_remotely.sh [options]"
    echo "Options:"
    echo '-s:   Remote address, if ommited $REMOTE_DEV_SERVER variable is used'
    echo '-u:   Remote user, if ommited $REMOTE_DEV_USER variable is used'
    echo ""
    echo "Example:"
    echo "run_nvim_remotely.sh -s <remote address> -u <remote user>"
    echo 'If the script run w/o argiments it uses $REMOTE_DEV_SERVER and $REMOTE_DEV_USER env variables'
}

while getopts "hs:u:p:" option; do
   case $option in
      h) # display Help
          help
         exit;;
      s) # incorrect option
         REMOTE_DEV_SERVER=$OPTARG
         ;;
      u) #
         REMOTE_DEV_USER=$OPTARG
         ;;
      p) #
         REMOTE_PATH=$OPTARG
         ;;
     \?) # incorrect option
         echo "Error: Invalid option"
         exit;;
   esac
done

echo " user:server: ${REMOTE_DEV_USER}@${REMOTE_DEV_SERVER}"
#find a free port
ports=($(ssh ${REMOTE_DEV_USER}@${REMOTE_DEV_SERVER} "ps -elf | \
                            grep -oP \"nvim --listen ${REMOTE_DEV_SERVER}:\d+\" | \
                            grep -oP \"\d+\" | uniq | sort"))

if [ -z $ports ]; then
    port=$MIN_PORT
else
    min_port=$(printf "%d\n" "${ports[@]}"| head -1)
    max_port=$(printf "%d\n" "${ports[@]}"| tail -1)
    if [ $min_port -gt $MIN_PORT ]; then
        port=$(($min_port-1))
    elif [ $max_port -lt $MAX_PORT ]; then
        port=$(($max_port+1))
    else
        echo "Unbale to find a free port!"
        exit 1
    fi
fi

#launch nvim remotely
echo "Launching nvim at ${REMOTE_DEV_SERVER}:${port}"
ssh ${REMOTE_DEV_USER}@${REMOTE_DEV_SERVER} \
    "nvim --listen ${REMOTE_DEV_SERVER}:${port} --headless \
    </dev/null >.nvim-remote.${port}.log 2>&1 &"

#launch local neovim-qt
${NVIM_QT_PATH} --server ${REMOTE_DEV_SERVER}:${port} &
