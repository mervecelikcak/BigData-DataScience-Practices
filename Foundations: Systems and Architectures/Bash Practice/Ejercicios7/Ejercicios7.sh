#!/bin/sh

# Name of the user who launched the rsyslogd process
ps aux | grep rsyslogd | awk '{print $1}'
ps aux | grep rsyslogd | grep -v "grep" | awk '{print $1}'
