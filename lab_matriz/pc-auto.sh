#!/bin/bash

export PATH=${PATH}:/usr/local/sbin:/usr/local/bin

cp /hostlab/shared/templates/tc /usr/sbin
cp /hostlab/shared/templates/sources.list /etc/apt

echo COMPLETE > /proc/mconsole
