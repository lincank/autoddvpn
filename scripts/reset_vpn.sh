#!/bin/sh
# Author: Guimin Lin
# Date: 07/01/2012
# Reset openvpn connection in dd-wrt router, for autoddvpn
# 
# cron:
# 00 5 * * 0-6/2 root /jffs/openvpn/resetVpn.sh 2>&1 >> /tmp/vpn_reset.log

echo "*********** VPN reset script starts ***********"
echo "[`date`]: Killing openvpn ..."
OPENVPN_NUM=`ps | grep openvpn | wc -l`
if [ ${OPENVPN_NUM} -ne 1 ]; then
	killall openvpn
fi
sleep 1

# reconnet vpn
openvpn --config /jffs/openvpn/openvpn.conf --daemon 
echo "[`date`]: Openvpn started! Reconnect succeed! End script"
echo "*********** VPN reset script ends ***********"
