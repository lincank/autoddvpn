#!/bin/sh


VPNGW=$(ifconfig tun0 |grep -Eo "P-t-P:([0-9.]+)" | cut -d: -f2)
route add -host ${1} gw $VPNGW
