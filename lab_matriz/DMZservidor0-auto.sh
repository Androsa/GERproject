#!/bin/bash

export PATH=${PATH}:/usr/local/sbin:/usr/local/bin

cp /hostlab/shared/templates/tc /usr/sbin
cp /hostlab/shared/templates/sources.list /etc/apt
ifconfig eth0 192.168.2.7 netmask 255.255.255.0

route add default gw 192.168.2.6
if [ -d "/hostlab/DMZservidor0/preserve" ]; then
  cd "/hostlab/DMZservidor0/preserve"; cp -r * /
fi
cp -p /hostlab/shared/templates/K95preserve /etc/rc0.d
echo -n > /etc/default/preserve
echo "/etc" >> /etc/default/preserve
/etc/init.d/cron start
/etc/init.d/ssh start
/etc/init.d/ntp start
sysctl -w net.ipv4.ip_forward=1
echo COMPLETE > /proc/mconsole
