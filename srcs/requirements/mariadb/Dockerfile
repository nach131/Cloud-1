FROM alpine:3.18.6

LABEL version="1.0"
LABEL description="MariaDB Server"

ENV MYSQL_DATA_DIR=/var/lib/mysql
VOLUME $MYSQL_DATA_DIR

# RUN apk update && \
RUN apk add --no-cache mariadb mariadb-client && \
	mkdir -p /var/lib/mysql && \
	chown -R mysql:mysql /var/lib/mysql && \
	mysql_install_db --user=mysql --ldata=/var/lib/mysql

# EXPOSE 3306

COPY ./conf/mariadb-server.cnf /etc/my.cnf.d/mariadb-server.cnf
COPY ./conf/my.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY ./tools/wp_db.sh /usr/local/bin/wp_db.sh

CMD ["mysqld_safe"]

WORKDIR /usr/local/bin
# RUN chmod +x ./wp_db.sh && ./wp_db.sh
# CMD ["sh", "-c", "/usr/bin/mysqld_safe && /home/db_init.sh"]