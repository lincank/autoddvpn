#!/bin/sh

nvram set jffs_mounted=1
nvram set enable_jffs2=1
nvram set sys_enable_jffs2=1
nvram set clean_jffs2=1
nvram set sys_clean_jffs2=1
nvram commit
reboot
