#!/bin/sh
# Author: Guimin Lin
# Date: 2012/7/3
# 被墙的网站，有时用的是DNS污染，此时用Google DNS来查其真实的ip地址
# Usage: multi_lookup.sh domain

echo "IP on default DNS: "
nslookup ${1} 
echo "IP on Google DNS: "
nslookup ${1} 8.8.8.8