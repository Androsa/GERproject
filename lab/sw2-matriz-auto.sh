#!/bin/bash

export PATH=${PATH}:/usr/local/sbin:/usr/local/bin

cp /hostlab/shared/templates/tc /usr/sbin
cp /hostlab/shared/templates/sources.list /etc/apt
ifconfig eth0 up

ifconfig eth1 up

ifconfig eth2 up

brctl addbr vlan1
brctl addif vlan1 eth0
brctl addif vlan1 eth1
brctl addif vlan1 eth2
ifconfig vlan1 up
echo COMPLETE > /proc/mconsole
