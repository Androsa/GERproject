#!/bin/bash

export PATH=${PATH}:/usr/local/sbin:/usr/local/bin

cp /hostlab/shared/templates/tc /usr/sbin
cp /hostlab/shared/templates/sources.list /etc/apt
ifconfig eth1 up

ifconfig eth2 up

ifconfig eth3 up

ifconfig eth4 up

ifconfig eth5 up

brctl addbr vlan1
brctl addif vlan1 eth1
brctl addif vlan1 eth2
brctl addif vlan1 eth3
brctl addif vlan1 eth4
brctl addif vlan1 eth5
ifconfig vlan1 up
echo COMPLETE > /proc/mconsole
