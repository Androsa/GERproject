#!/bin/bash

export PATH=${PATH}:/usr/local/sbin:/usr/local/bin

cp /hostlab/shared/templates/tc /usr/sbin
cp /hostlab/shared/templates/sources.list /etc/apt
ifconfig eth0 192.168.0.5 netmask 255.255.255.0

ifconfig eth1 192.168.2.6 netmask 255.255.255.0


/etc/init.d/cron start
/etc/init.d/ssh start
sysctl -w net.ipv4.ip_forward=1
iptables -t nat -A POSTROUTING -o eth2 -j MASQUERADE
echo COMPLETE > /proc/mconsole
