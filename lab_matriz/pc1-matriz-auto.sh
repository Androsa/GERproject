#!/bin/bash

export PATH=${PATH}:/usr/local/sbin:/usr/local/bin

cp /hostlab/shared/templates/tc /usr/sbin
cp /hostlab/shared/templates/sources.list /etc/apt
ifconfig eth0 up
dhclient -nw eth0

/etc/init.d/cron start
/etc/init.d/ssh start
echo COMPLETE > /proc/mconsole
