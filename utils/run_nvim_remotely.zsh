#!/bin/zsh

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
    echo '-p:   Remote path, if contains tilde(~) needs to be wrapped with quotes("")'
    echo ""
    echo "Example:"
    echo "rgvim -s <remote address> -u <remote user>"
    echo 'If the script is launched w/o arguments it uses $REMOTE_DEV_SERVER and $REMOTE_DEV_USER env variables'
}

remote_gvim_helper() {
    local docker_internal_port=7777
    local server=$REMOTE_DEV_SERVER
    local user=$REMOTE_DEV_USER
    local path=$REMOTE_PATH
    local remote_container=""
    while getopts "hs:u:p:C:" option; do
       case $option in
          h) # display Help
              help
             return;;
          s) #
             server=$OPTARG
             ;;
          u) #
             user=$OPTARG
             ;;
          p) #
             path=$OPTARG
             ;;
          C) #
             remote_container=$OPTARG
             ;;
         \?) # incorrect option
             echo "Error: Invalid option"
             return;;
       esac
    done

    if [[ -z ${server} || -z ${user} ]]; then
        echo "Please set server and user"
        help
        return
    fi

    #find a free port
    if [[ -n ${remote_container} ]]; then
        local port=($(/usr/bin/ssh ${user}@${server} "\
                    docker port ${remote_container} | sed \"s/${docker_internal_port}\/tcp.*://\""))
        /usr/bin/ssh ${user}@${server} \
            "docker exec -dit \
            ${remote_container} /bin/bash -c \"nvim --listen 0.0.0.0:${docker_internal_port} --headless\" \
            </dev/null > /dev/null 2>&1"
    else
        local ports=($(/usr/bin/ssh ${user}@${server} "ps -elf | \
                            grep -oP \"nvim --listen ${server}:\d+\" | sed \"s/.*://\" | uniq | sort"))

        local port=$MIN_PORT
        if [ -n "$ports" ]; then
            local min_port=$(printf "%d\n" "${ports[@]}"| /usr/bin/head -1)
            local max_port=$(printf "%d\n" "${ports[@]}"| /usr/bin/tail -1)
            if [ $min_port -gt $MIN_PORT ]; then
                port=$(($min_port-1))
            elif [ $max_port -lt $MAX_PORT ]; then
                port=$(($max_port+1))
            else
                echo "Unable to find a free port!"
                return
            fi
        fi
        echo "Launching nvim: cd ${path} && nvim --listen ${server}:${port} --headless \
            </dev/null > /dev/null 2>&1 &"
        /usr/bin/ssh ${user}@${server} \
            "cd ${path} && nvim --listen ${server}:${port} --headless \
            </dev/null > /dev/null 2>&1 &"
    fi

    #launch local neovim-qt
    echo "Launch: ${NVIM_QT_PATH} --server ${server}:${port} & disown"
    ${NVIM_QT_PATH} --server ${server}:${port} & disown
}

alias rgvim='remote_gvim_helper'
