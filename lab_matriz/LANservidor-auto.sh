#!/bin/bash

export PATH=${PATH}:/usr/local/sbin:/usr/local/bin

cp /hostlab/shared/templates/tc /usr/sbin
cp /hostlab/shared/templates/sources.list /etc/apt
if [ -d "/hostlab/LANservidor/preserve" ]; then
  cd "/hostlab/LANservidor/preserve"; cp -r * /
fi
cp -p /hostlab/shared/templates/K95preserve /etc/rc0.d
echo -n > /etc/default/preserve
echo "generic" >> /etc/default/preserve
echo COMPLETE > /proc/mconsole
