FROM alpine:3.18.6

LABEL version="1.0"
LABEL description="NGINX Server"

# Actualizar el índice de paquetes e instalar NGINX
RUN apk update && apk add --no-cache nginx openssl

COPY ./conf/nginx.conf /etc/nginx/nginx.conf
COPY ./conf/nmota-bu.42.fr /etc/nginx/conf.d/nmota-bu.42.fr.conf
COPY ./conf/nasa.nmota-bu.42.fr /etc/nginx/conf.d/nasa.nmota-bu.42.fr.conf
COPY ./conf/adminer.nmota-bu.42.fr /etc/nginx/conf.d/adminer.nmota-bu.42.fr.conf

# Primera vez
# COPY ./tools/cert.sh /usr/local/bin/cert.sh
# RUN chmod +x /usr/local/bin/cert.sh
# ENTRYPOINT [ "/usr/local/bin/cert.sh" ]

COPY ./conf/nginx.crt /etc/ssl/certs/nginx.crt
COPY ./conf/nginx.key /etc/ssl/private/nginx.key

WORKDIR /var/www

# Comando para ejecutar NGINX en primer plano
CMD ["nginx", "-g", "daemon off;"]
