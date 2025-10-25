#!/bin/sh
# Rotar logs cada hora
while 42; do
    logrotate -f /etc/logrotate.conf
    sleep 3600
done
