#!/bin/sh
LOG_FILE=/jffs/wifi.log
dmesg | tail -n 3 | grep -q Resetting || return 
echo Resetting Wifi... 
echo Reset Wifi at: >> $LOG_FILE
date >> $LOG_FILE
echo "" >> $LOG_FILE
ifconfig ath0 down 
sleep 2 
ifconfig ath0 up