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
    echo "need more args: ${@}"
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
ADDR_LIST=${@}
if [ ${MODE} == "h" ]; then
    for addr in $ADDR_LIST; do
        echo "route add -host ${addr} gw $VPNGW"
        route add -host ${addr} gw $VPNGW
    done

elif [ ${MODE} == "n" ]; then
    for addr in $ADDR_LIST; do
        echo "route add -net ${addr} gw $VPNGW"
        route add -net ${addr} gw $VPNGW
    done
else
    usage 
fi
