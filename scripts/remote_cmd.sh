#!/bin/sh
# Author: Guimin Lin
# Date: 2012/8/9
# 
# A helper script to run command on router

usage()
{
    echo "Usage: `basename ${0}` [OPTIONS] command"
    echo "\t-p PATH"
    echo "e.g. remote_cmd.sh add2route.sh -h 8.8.8.8"
}



if [ "$#" -lt 1 ]; then
    usage
    exit 1
fi

# default path
PREFIX='/jffs/openvpn'

while getopts ":p:" opt; do
     case $opt in
         p) 
             PREFIX=$OPTARG
             ;;
         \?) 
             echo "Invalid option: -$OPTARG" >&2
             usage
             exit 1
             ;;
         :)
             echo "Option -$OPTARG requires an argument." >&2
             usage
             exit 1
             ;;
     esac
done

shift `expr $OPTIND - 1`

COMMAND=${PREFIX}/${1}

shift
echo "runing $COMMAND $@"

# get router ip
GW=`netstat -rn | grep UG |tr -s ' '|cut -d ' ' -f2`

ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null root@${GW} "$COMMAND $@"
