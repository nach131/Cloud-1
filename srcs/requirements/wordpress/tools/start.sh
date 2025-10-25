#!/bin/sh
set -e

# Iniciar php-fpm en segundo plano
php-fpm &

sleep 5

# Iniciar Redis en segundo plano después de un breve retraso
redis-server &

# Esperar que ambos procesos estén en ejecución
wait
