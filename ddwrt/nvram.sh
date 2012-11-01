#!/bin/sh

nvram set rc_startup=' openvpn --config /jffs/openvpn/openvpn.conf --daemon'
nvram commit