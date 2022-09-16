#!/bin/bash

create_user(){
    docker exec -it samba ./utils/add_user.sh $1 $2
}

docker-compose up -d
create_user $1 $2
