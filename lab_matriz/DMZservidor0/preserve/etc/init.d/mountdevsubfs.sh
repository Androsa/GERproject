#! /bin/sh
### BEGIN INIT INFO
# Provides:          mountdevsubfs
# Required-Start:    mountkernfs
# Required-Stop:
# Should-Start:      udev
# Default-Start:     S
# Default-Stop:
# Short-Description: Mount special file systems under /dev.
# Description:       Mount the virtual filesystems the kernel provides
#                    that ordinarily live under the /dev filesystem.
### END INIT INFO
#
# This script gets called multiple times during boot
#

PATH=/lib/init:/sbin:/bin
TTYGRP=5
TTYMODE=620
[ -f /etc/default/devpts ] && . /etc/default/devpts

TMPFS_SIZE=
[ -f /etc/default/tmpfs ] && . /etc/default/tmpfs

KERNEL="$(uname -s)"

. /lib/lsb/init-functions
. /lib/init/mount-functions.sh

do_start () {
	#
	# Mount a tmpfs on /dev/shm
	#
	SHM_OPT=
	[ "${SHM_SIZE:=$TMPFS_SIZE}" ] && SHM_OPT=",size=$SHM_SIZE"
	domount tmpfs shmfs /dev/shm tmpfs -onosuid,nodev$SHM_OPT

	#
	# Mount /dev/pts. Create master ptmx node if needed.
	#
	# As of 2.5.68, devpts is not automounted when using devfs. So we
	# mount devpts if it is compiled in (older devfs didn't require it
	# to be compiled in at all).
	#
	if [ "$KERNEL" = Linux ]
	then
		#
		# Since kernel 2.5.something, devfs doesn't include
		# a standard /dev/pts directory anymore. So if devfs
		# is mounted on /dev we need to create that directory
		# manually.
		#
		if [ ! -d /dev/pts ]
		then
			if grep -qs '/dev devfs' /proc/mounts
			then
				mkdir --mode=755 /dev/pts
				[ -x /sbin/restorecon ] && /sbin/restorecon /dev/pts
			fi
		fi
		if [ -d /dev/pts ]
		then
			if [ ! -c /dev/ptmx ]
			then
				mknod --mode=666 /dev/ptmx c 5 2
				ES=$?
				if [ "$ES" != 0 ]
				then
					log_warning_msg "Failed making node /dev/ptmx with error code ${ES}."
				fi
				[ -x /sbin/restorecon ] && /sbin/restorecon /dev/ptmx
			fi
			domount devpts "" /dev/pts devpts -onoexec,nosuid,gid=$TTYGRP,mode=$TTYMODE
		fi
	fi
}

case "$1" in
  "")
	echo "Warning: mountdevsubfs should be called with the 'start' argument." >&2
	do_start
	;;
  start)
	do_start
	;;
  restart|reload|force-reload)
	echo "Error: argument '$1' not supported" >&2
	exit 3
	;;
  stop)
	# No-op
	;;
  *)
	echo "Usage: mountdevsubfs [start|stop]" >&2
	exit 3
	;;
esac
