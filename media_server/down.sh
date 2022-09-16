#!/bin/bash

set -a # automatically export all variables
source .env
set +a

remove_users() {
    # clear created varenvs
    for name in ${CONTAINER_NAMES[@]}; do
        echo "removing $name"
        sudo userdel "$name"
    done
}

remove_group(){
    groupdel ${STACK_GROUP_NAME}
}

docker-compose down
remove_users
