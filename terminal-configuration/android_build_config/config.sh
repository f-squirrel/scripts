#!/bin/bash

cwd=$(pwd)

source ./switch_to_bash.sh

source /etc/profile

source ./goto_android_dir.sh

source ./build/envsetup.sh

source $cwd/goto_dreamrouter.sh 
