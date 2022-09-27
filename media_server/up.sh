#!/bin/bash

set -a # automatically export all variables
source .env
set +a
USER_IDS=()
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
        USER_IDS+=("$var_name=$uid")
    done
}

docker_compose_up(){
    eval "${USER_IDS[@]}" "HOME_GROUP_GUID=$STACK_GROUP_ID" docker-compose up -d
}

create_home_group
create_users
docker_compose_up
