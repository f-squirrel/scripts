#!/bin/sh

ROOT_DIR=$HOME
SRC="/Volumes/Macintosh HD/Users/skyjack/Pictures/iPhoto Library.photolibrary/"
DST="$ROOT_DIR/Cloud@Mail.Ru/photo/iPhoto Library.photolibrary/"

SUCCESS_COLOR=2
ERROR_COLOR=1
MESSAGE_COLOR=4

function log {
    echo $(tput setaf ${1})"$2"
}

function log_success {
    log ${SUCCESS_COLOR} "$1"
}

function log_error {
    log ${ERROR_COLOR} "$1"
}

function log_message {
    log ${MESSAGE_COLOR} "$1"
}

function run_rsync {
    echo "Starting rsync"

    local src="${1}"
    local dst="${2}"

    rsync -rah --delete --progress --human-readable "${src}" "${dst}"

    if [[ $? == 0 ]]; then
        log_success "Rsync finished successfully"
    else
        log_error "Rsync FAILED"
    fi
}

function is_process_running {
    local APP_NAME=$1
    number=$(ps xc | grep "$APP_NAME" | wc -l)

    if [ $number -gt 0 ]; then
    	echo TRUE
    else
    	echo FALSE
    fi
}


function main {

    APP_NAME="iPhoto"
    RES=$(is_process_running "$APP_NAME")
    if [ "$RES"  == "TRUE" ] ; then
        log_error "Cannot rsync: '$APP_NAME' is running"
        exit
    fi

    APP_NAME="Aperture"
    RES="$(is_process_running "$APP_NAME")"

    if [ "$RES"  == "TRUE" ] ; then
        log_error "Cannot rsync: '$APP_NAME' is running"
        exit
    fi

    run_rsync "${SRC}" "${DST}"
}

main $@
