#!/bin/sh
scp -o UserKnownHostsFile=/dev/null ${2}  root@192.168.${1}.1:/jffs/openvpn/