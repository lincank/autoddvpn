#!/bin/sh
# Author: Guimin Lin
# Date: 2012/8/4
# 
# Look up domain's ip with Google DNS 
# Optional: 
# 1. -h : print in route add format, as in vpnup_custome
#    e.g. "route add -host 8.8.8.8 gw \$VPNGW"
# BASEDIR=$(dirname $0)

usage()
{
    echo Usage: `basename ${0}` -h domain
    echo "\t -h : print in route add format, as in vpnup_custome"
}

if [ $# -lt 1 ]; then
    usage
    exit 1
fi

HOST_FORMAT=0
while getopts ":h" opt; do
     case $opt in
         h) 
             HOST_FORMAT=1
             ;;
         \?) 
             echo "Invalid option: -$OPTARG" >&2
             usage
             exit 1
             ;;
     esac
done

shift `expr $OPTIND - 1`

TEMP=`nslookup ${1} 8.8.8.8 | grep -Eo "[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}" `
RECORD_NUM=`echo $TEMP | wc -w`

if [ ${RECORD_NUM} -lt 3 ]; then
    echo "nsloop fail!"
    exit 1
fi

# first two IPs are name server, discard
ADDR_LIST=`echo $TEMP | cut -d ' ' -f 3-`

for addr in $ADDR_LIST; do
    if [ $HOST_FORMAT -eq 1 ]; then
        echo "route add -host $addr gw \$VPNGW"
    else
        echo $addr
    fi
done









