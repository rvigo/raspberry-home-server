#!/bin/bash

adduser -s /sbin/nologin -h /home/$1 -H -D $1
smbpasswd -a $1
