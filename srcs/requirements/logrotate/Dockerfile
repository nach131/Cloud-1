FROM alpine:3.21

RUN apk add --no-cache logrotate busybox-suid

COPY logrotate.conf /etc/logrotate.conf
RUN chmod 644 /etc/logrotate.conf

COPY run-logrotate.sh /usr/local/bin/run-logrotate.sh
RUN chmod +x /usr/local/bin/run-logrotate.sh

# CMD ["crond", "-f"]
CMD ["/usr/local/bin/run-logrotate.sh"]

# Ejecutar dentro del contenedor
# logrotate -f /etc/logrotate.conf
