#!/bin/sh
# Author: Guimin Lin
# Date: 2012/11/14
#
# reconnect vpn if found no connection
# cron job to run every minute:
# * * * * * root /jffs/openvpn/vpn_daemon.sh 2>&1 >> /tmp/vpn_reset.log


OPENVPN_NUM=`ps | grep "openvpn --config" | wc -l`
if [ ${OPENVPN_NUM} -ne 2 ]; then
    echo "unexpected number of openvpn process: ${OPENVPN_NUM}"
    killall openvpn
    sleep 1
    openvpn --config /jffs/openvpn/openvpn.conf --daemon    
    echo "[`date`]: Openvpn process not found, restarted!"
fi

