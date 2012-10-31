#!/bin/sh

# router ip
GW=`netstat -rn | grep UG |tr -s ' '|cut -d ' ' -f2`

scp -r -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null ${1} root@${GW}:/jffs/openvpn/


#ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null root@${GW} "/jffs/openvpn/resetVpn.sh"



