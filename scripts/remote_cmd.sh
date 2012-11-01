#!/bin/sh


GW=`netstat -rn | grep UG |tr -s ' '|cut -d ' ' -f2`

ssh  -o StrictHostKeyChecking=no  root@${GW} "${1}"
