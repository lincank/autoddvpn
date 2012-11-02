#!/bin/sh
# Author: Guimin Lin
# Date: 2012/8/9
# 
# A helper script to run command on router

# get router ip
GW=`netstat -rn | grep UG |tr -s ' '|cut -d ' ' -f2`

ssh  -o StrictHostKeyChecking=no  root@${GW} "${@}"
