#!/bin/sh

SSL_CERT="/etc/ssl/certs/nginx.crt"
SSL_KEY="/etc/ssl/private/nginx.key"
SSL_SUBJECT="/C=ES/ST=Barcelona/L=Barcelona/O=AcmeCo/CN=nmota-bu.42.fr"
DAYS=730

if [ ! -f "$SSL_CERT" ]; then
    echo "Setting up SSL for Nginx..."

    # Generate SSL certificate and key
    openssl req -x509 -nodes -days "$DAYS" -newkey rsa:4096 -keyout "$SSL_KEY" -out "$SSL_CERT" -subj "$SSL_SUBJECT"

    echo "SSL setup for Nginx is complete!"
fi

# Execute the provided command or entry point
exec "$@"
