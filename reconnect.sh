#!/bin/sh
# Author: Guimin Lin
# 
# This script can reconnect internet in dd-wrt devices
# reconnect PPPoE every two days by cron job
# 
# cron job: 00 5 * * 1-7/2 root /jffs/openvpn/reconnect.sh

LOG_FILE=/tmp/reconnect.log
echo "----------------------------------------------" >> $LOG_FILE
echo "[`date`]: Reconnect script start ..." >> $LOG_FILE
echo "[`date`]: Killing pppd ..." >> $LOG_FILE
killall pppd

# check if killing succeed
if [ $? -eq 0 ]; then
	echo "[`date`]: pppd killed ..." >> $LOG_FILE
else
	echo "[`date`]: error in killing pppd! Exiting ..." >> $LOG_FILE
	exit 1
fi

echo "[`date`]: Wait for reconnect ..." >> $LOG_FILE
sleep 3

PPPoE_NUM=`ps | grep pppd | wc -l`
while [ ${PPPoE_NUM} -ne 2 ]; do
	sleep 2;
	pppd file /tmp/ppp/options.pppoe # start pppd manually
	PPPoE_NUM=`ps | grep pppd | wc -l`
done
echo "[`date`]: Time to start openvpn ..." >> $LOG_FILE


OPENVPN_NUM=`ps | grep openvpn | wc -l`
if [ ${OPENVPN_NUM} -ne 1 ]; then
	killall openvpn
fi
openvpn --config /jffs/openvpn/openvpn.conf --daemon 
echo "[`date`]: Openvpn started! Reconnect succeed! End script" >> $LOG_FILE
