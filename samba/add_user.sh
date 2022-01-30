#!/bin/bash

adduser -u $2 -s /sbin/nologin -h /home/$1 -H -D $1
smbpasswd -a $1
