#!/bin/sh
# Author: Guimin Lin
# Date: 2012/8/4
# 
# Look up domain's ip with Google DNS 
# Optional: 
# 1. -h : print in route add format, as in vpnup_custome
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

TEMP=`nslookup ${1} 8.8.8.8 | grep Address | wc -l`

if [ ${TEMP} -lt 2 ]; then
    echo "nsloop fail!"
    `nslookup ${1} 8.8.8.8`
    exit 1
fi

LINE_NUM=`expr $TEMP - 1`
ADDR_LIST=`nslookup ${1} 8.8.8.8 | grep Address | tail -n $LINE_NUM | cut -d ' ' -f 2`


for addr in $ADDR_LIST; do
    if [ $HOST_FORMAT -eq 1 ]; then
        echo "route add -host $addr gw \$VPNGW"
    else
        echo $addr
    fi
done









