#!/bin/sh


GW=`netstat -rn | grep UG |tr -s ' '|cut -d ' ' -f2`

ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no  root@${GW} "${1}"
