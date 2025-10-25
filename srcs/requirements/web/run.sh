#!/bin/bash

set -e

envsubst < /etc/nginx/default.conf.tpl > /etc/nginx/conf.d/default.conf
# Ejecutar Nginx en primer plano
nginx -g 'daemon off;'