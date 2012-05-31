#!/bin/sh -e

### BEGIN INIT INFO
# Provides:          vpn
# Required-Start:    $network $local_fs
# Required-Stop:     $network $local_fs
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Openvpn VPN service
### END INIT INFO

# Original version by Robert Leslie
# <rob@mars.org>, edited by iwj and cs
# Modified for openvpn by Alberto Gonzalez Iniesta <agi@inittab.org>
# Modified for restarting / starting / stopping single tunnels by Richard Mueller <mueller@teamix.net>

. /lib/lsb/init-functions

test $DEBIAN_SCRIPT_DEBUG && set -v -x

DAEMON=/usr/sbin/openvpn
DESC="virtual private network daemon"
CONFIG_DIR=/etc/openvpn
test -x $DAEMON || exit 0
test -d $CONFIG_DIR || exit 0

# Source defaults file; edit that file to configure this script.
AUTOSTART="all"
STATUSREFRESH=10
if test -e /etc/default/openvpn ; then
  . /etc/default/openvpn
fi

start_vpn () {
    if grep -q '^[	 ]*daemon' $CONFIG_DIR/$NAME.conf ; then
      # daemon already given in config file
      DAEMONARG=
    else
      # need to daemonize
      DAEMONARG="--daemon ovpn-$NAME"
    fi

    if grep -q '^[	 ]*status ' $CONFIG_DIR/$NAME.conf ; then
      # status file already given in config file
      STATUSARG=""
    elif test $STATUSREFRESH -eq 0 ; then
      # default status file disabled in /etc/default/openvpn
      STATUSARG=""
    else
      # prepare default status file
      STATUSARG="--status /var/run/openvpn.$NAME.status $STATUSREFRESH"
    fi

    log_progress_msg "$NAME"
    STATUS=0

    # Check to see if it's already started...
    if test -e /var/run/openvpn.$NAME.pid ; then
      log_failure_msg "Already running (PID file exists)"
      STATUS=0
    else
      $DAEMON $OPTARGS --writepid /var/run/openvpn.$NAME.pid \
	      $DAEMONARG $STATUSARG --cd $CONFIG_DIR \
	      --config $CONFIG_DIR/$NAME.conf || STATUS=1
    fi
}
stop_vpn () {
  kill `cat $PIDFILE` || true
  rm -f $PIDFILE
  rm -f /var/run/openvpn.$NAME.status 2> /dev/null
}

case "$1" in
start)
  log_daemon_msg "Starting $DESC"

  # autostart VPNs
  if test -z "$2" ; then
    # check if automatic startup is disabled by AUTOSTART=none
    if test "x$AUTOSTART" = "xnone" -o -z "$AUTOSTART" ; then
      log_warning_msg " Autostart disabled."
      exit 0
    fi
    if test -z "$AUTOSTART" -o "x$AUTOSTART" = "xall" ; then
      # all VPNs shall be started automatically
      for CONFIG in `cd $CONFIG_DIR; ls *.conf 2> /dev/null`; do
        NAME=${CONFIG%%.conf}
        start_vpn
      done
    else
      # start only specified VPNs
      for NAME in $AUTOSTART ; do
        if test -e $CONFIG_DIR/$NAME.conf ; then
          start_vpn
        else
          log_failure_msg "No such VPN: $NAME"
          STATUS=1
        fi
      done
    fi
  #start VPNs from command line
  else
    while shift ; do
      [ -z "$1" ] && break
      if test -e $CONFIG_DIR/$1.conf ; then
        NAME=$1
        start_vpn
      else
       log_failure_msg " No such VPN: $1"
       STATUS=1
      fi
    done
  fi
  log_end_msg ${STATUS:-0}

  ;;
stop)
  log_daemon_msg "Stopping $DESC"

  if test -z "$2" ; then
    for PIDFILE in `ls /var/run/openvpn.*.pid 2> /dev/null`; do
      NAME=`echo $PIDFILE | cut -c18-`
      NAME=${NAME%%.pid}
      stop_vpn
      log_progress_msg "$NAME"
    done
  else
    while shift ; do
      [ -z "$1" ] && break
      if test -e /var/run/openvpn.$1.pid ; then
        PIDFILE=`ls /var/run/openvpn.$1.pid 2> /dev/null`
        NAME=`echo $PIDFILE | cut -c18-`
        NAME=${NAME%%.pid}
        stop_vpn
        log_progress_msg "$NAME"
      else
        log_failure_msg " (failure: No such VPN is running: $1)"
      fi
    done
  fi
  log_end_msg 0
  ;;
# Only 'reload' running VPNs. New ones will only start with 'start' or 'restart'.
reload|force-reload)
 log_daemon_msg "Reloading $DESC"
  for PIDFILE in `ls /var/run/openvpn.*.pid 2> /dev/null`; do
    NAME=`echo $PIDFILE | cut -c18-`
    NAME=${NAME%%.pid}
# If openvpn if running under a different user than root we'll need to restart
    if egrep '^[[:blank:]]*user[[:blank:]]' $CONFIG_DIR/$NAME.conf > /dev/null 2>&1 ; then
      stop_vpn
      sleep 1
      start_vpn
      log_progress_msg "(restarted)"
    else
      kill -HUP `cat $PIDFILE` || true
    log_progress_msg "$NAME"
    fi
  done
  log_end_msg 0
  ;;

# Only 'soft-restart' running VPNs. New ones will only start with 'start' or 'restart'.
soft-restart)
 log_daemon_msg "$DESC sending SIGUSR1"
  for PIDFILE in `ls /var/run/openvpn.*.pid 2> /dev/null`; do
    NAME=`echo $PIDFILE | cut -c18-`
    NAME=${NAME%%.pid}
    kill -USR1 `cat $PIDFILE` || true
    log_progress_msg "$NAME"
  done
  log_end_msg 0
 ;;

restart)
  shift
  $0 stop ${@}
  sleep 1
  $0 start ${@}
  ;;
cond-restart)
  log_daemon_msg "Restarting $DESC."
  for PIDFILE in `ls /var/run/openvpn.*.pid 2> /dev/null`; do
    NAME=`echo $PIDFILE | cut -c18-`
    NAME=${NAME%%.pid}
    stop_vpn
    sleep 1
    start_vpn
  done
  log_end_msg 0
  ;;
*)
  echo "Usage: $0 {start|stop|reload|restart|force-reload|cond-restart}" >&2
  exit 1
  ;;
esac

exit 0

# vim:set ai sts=2 sw=2 tw=0:
