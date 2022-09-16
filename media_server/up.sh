#!/bin/bash

set -a # automatically export all variables
source .env
set +a

create_home_group(){
    # creates local stack group
    sudo groupadd -g $STACK_GROUP_ID -r $STACK_GROUP_NAME
}

create_users() {
    # creates local users
    for name in ${CONTAINER_NAMES[@]}; do
        upper_name="$(echo $name | sed -e 's/\(.*\)/\U\1/')"
        sudo useradd -G $STACK_GROUP_NAME $name
        var_name="${upper_name}_UID"
        uid=$(id -u $name)
        eval "$var_name"="$uid"
    done
}

cleanup() {
    # clear created varenvs
    for name in ${CONTAINER_NAMES[@]}; do
        upper_name="$(echo $name | sed -e 's/\(.*\)/\U\1/')"
        var_name="${upper_name}_UID"
        unset "$var_name"
    done
}

docker_compose_up(){
    docker-compose up -d
}

create_home_group
create_users
docker_compose_up
cleanup
