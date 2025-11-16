#!/bin/sh
# Rotar logs cada hora
while true; do
    logrotate -f /etc/logrotate.conf
    sleep 3600
done
