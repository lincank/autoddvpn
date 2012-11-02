#!/bin/sh
# Author: Guimin Lin
# Date: 2012/9/7
# 
# Add custom route to iptable for host or net
# Usage: add2route.sh -[h|n] ip

usage()
{
    echo "Usage: add2route.sh -[h|n] ip"
}

if [ $# -lt 2 ]; then
    usage
    exit 1
fi

MODE=''
while getopts ":nh" opt; do
     case $opt in
         h) 
             MODE="h"
             ;;
         n)
             MODE="n"
             ;;
         \?) 
             echo "Invalid option: -$OPTARG" >&2
             usage
             exit 1
             ;;
     esac
done
shift `expr $OPTIND - 1`

# VPN gateway address
VPNGW=$(ifconfig tun0 |grep -Eo "P-t-P:([0-9.]+)" | cut -d: -f2)

if [ ${MODE} == "h" ]; then
    echo "route add -host ${1} gw $VPNGW"
    route add -host ${1} gw $VPNGW
elif [ ${MODE} == "n" ]; then
    echo "route add -net ${1} gw $VPNGW"
    route add -net ${1} gw $VPNGW 
else
    usage 
fi
