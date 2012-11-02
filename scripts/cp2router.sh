#!/bin/sh
# Author: Guimin Lin
# Date: 2012/7/6
# 
# Helper script for copying files to route in /jffs/openvpn dir

# router ip
GW=`netstat -rn | grep UG |tr -s ' '|cut -d ' ' -f2`

scp -r -o StrictHostKeyChecking=no  ${@} root@${GW}:/jffs/openvpn/



