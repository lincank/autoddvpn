#!/bin/sh

if [ $# -lt 2 ]; then
    echo "Invalid args, usage: ${0} file_name domain"
    exit
fi

TEMP=`nslookup ${2} 8.8.8.8 | grep Address | wc -l`

if [ ${TEMP} -lt 2 ]; then
    echo "nsloop fail!"
    `nslookup ${2} 8.8.8.8`
    exit
fi

LINE_NUM=`expr $TEMP - 1`
ADDR_LIST=`nslookup ${2} 8.8.8.8 | grep Address | tail -n $LINE_NUM | cut -d ' ' -f 2`

echo "# ${2}" >> ${1}
for addr in $ADDR_LIST
do
    echo "appending $addr ..."
    ./append2custom.sh ${1} h ${addr}
done

echo "Successfully append $LINE_NUM IPs!"


