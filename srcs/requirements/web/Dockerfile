FROM nginx:latest

COPY ./default.conf.tpl /etc/nginx/default.conf.tpl

COPY ./run.sh /run.sh

RUN touch /etc/nginx/conf.d/default.conf && \
	chown nginx:nginx /etc/nginx/conf.d/default.conf && \
	chmod +x /run.sh

CMD ["/run.sh"]
