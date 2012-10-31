#!/bin/sh
# Author: Guimin Lin
# Date: 2012/9/7
# 
# Add custom route to iptable for host or net
# Usage: add2route.sh -[h|n] ip

usage()
{
    echo "Usage: add2route.sh -[h|n] ip"
    echo e.g. 
    echo host: add2route.sh h 2.2.2.2 
    echo net: add2route.sh n 2.2.2.0/24
}

# VPN gateway address
VPNGW=$(ifconfig tun0 |grep -Eo "P-t-P:([0-9.]+)" | cut -d: -f2)

if [ ${1} == "h" ]; then
    echo "route add -host ${2} gw $VPNGW"
    route add -host ${2} gw $VPNGW
elif [ ${1} == "n" ]; then
    echo "route add -net ${2} gw $VPNGW"
    route add -net ${2} gw $VPNGW 
else
    usage 
fi
