#!/bin/sh

if [ $# -lt 3 ]; then
    echo "must have at lease 3 args: file_name, mode, ip"
    exit
elif [ ! -f ${1} ]; then
    echo " First arg must be input file"
    exit
fi

if [ ${2} == "h" ]; then
    echo "route add -host ${3} gw \$VPNGW"
    echo "route add -host ${3} gw \$VPNGW" >> ${1} 
elif [ ${2} == "n" ]; then
    echo "route add -net ${3} gw \$VPNGW"
    echo "route add -net ${3} gw \$VPNGW" >> ${1} 
else
    echo "Invalid mode, must be h or n"
fi
