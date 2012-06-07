#!/bin/sh
echo "IP on default DNS: "
nslookup ${1} 
echo "IP on default Google DNS: "
nslookup ${1} 8.8.8.8