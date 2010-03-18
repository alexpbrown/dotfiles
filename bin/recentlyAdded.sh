#!/bin/sh
#from archlinux forums; posted by Morra

awk '{if ($6=="added") {sub(".*added ",""); line++; list[line]=$0}} END {for (i=line-10; i<line ;i++) {print list[i]}}' /var/log/mpd/mpd.log | mpc add
