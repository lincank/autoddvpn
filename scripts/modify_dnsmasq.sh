#!/bin/sh

cat /jffs/openvpn/gfwdomains.conf >> /tmp/dnsmasq.conf 
killall dnsmasq
dnsmasq --conf-file=/tmp/dnsmasq.conf
