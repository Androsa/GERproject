#!/bin/bash

export PATH=${PATH}:/usr/local/sbin:/usr/local/bin

cp /hostlab/shared/templates/tc /usr/sbin
cp /hostlab/shared/templates/sources.list /etc/apt
ifconfig eth0 up
dhclient -nw eth0

route add default gw 192.168.3.254
echo COMPLETE > /proc/mconsole
