#!/bin/bash

export PATH=${PATH}:/usr/local/sbin:/usr/local/bin

cp /hostlab/shared/templates/tc /usr/sbin
cp /hostlab/shared/templates/sources.list /etc/apt
ifconfig eth0 192.168.3.254 netmask 255.255.255.0


if [ -d "/hostlab/firewall0/preserve" ]; then
  cd "/hostlab/firewall0/preserve"; cp -r * /
fi
cp -p /hostlab/shared/templates/K95preserve /etc/rc0.d
echo -n > /etc/default/preserve
echo "/etc/bind" >> /etc/default/preserve
echo "/etc/dhcp3" >> /etc/default/preserve
echo "/etc/rc.local" >> /etc/default/preserve
sysctl -w net.ipv4.ip_forward=1
iptables -t nat -A POSTROUTING -o eth1 -j MASQUERADE
echo COMPLETE > /proc/mconsole
