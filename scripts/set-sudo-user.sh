#!/bin/bash
if [ $# -eq 0 ]; then
    echo "./set-sudo-user.sh $(whoami)"
    exit 1
fi

insert="$1 ALL=(ALL:ALL) ALL"
cmd="sudo sed -i '/# User privilege specification/a $insert' /etc/sudoers"
eval $cmd
insert="$1 ALL=(ALL:ALL) NOPASSWD: ALL"
cmd="sudo sed -i '/#includedir \/etc\/sudoers.d/a $insert' /etc/sudoers"
eval $cmd

sudo usermod -aG sudo $1

