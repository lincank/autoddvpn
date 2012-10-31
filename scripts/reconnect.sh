#!/bin/sh
# Author: Guimin Lin
# Date: 2012/7/8
# 
# This script restart connection and reset VPN in dd-wrt router
# 
# Use the following cron job to reconnect PPPoE every two days:
# 00 5 * * 1-7/2 root /jffs/openvpn/reconnect.sh 2>&1 >> /tmp/reconnect.log

echo "----------------------------------------------" 
echo "[`date`]: Reconnect script start ..." 
echo "[`date`]: Killing pppd ..." 
killall pppd

# check if killing succeed
if [ $? -eq 0 ]; then
	echo "[`date`]: pppd killed ..." 
else
	echo "[`date`]: error in killing pppd! Exiting ..." 
	exit 1
fi

echo "[`date`]: Wait for reconnect ..." 
sleep 3

PPPoE_NUM=`ps | grep pppd | wc -l`
while [ ${PPPoE_NUM} -ne 2 ]; do
	sleep 2;

    # start pppd manually
	pppd file /tmp/ppp/options.pppoe 
	PPPoE_NUM=`ps | grep pppd | wc -l`
done
echo "[`date`]: Time to start openvpn ..." 

# call reset vpn script
/jffs/openvpn/reset_vpn.sh
