# start from a debian image base
FROM debian:bullseye

# update and install packages
RUN apt-get update -y && \
	apt-get upgrade -y && \
	apt-get install -y vim && \
	apt-get install -y nginx && \
	apt-get install -y openssl

# generate self-signed SSL certificates and key
RUN mkdir -p /etc/nginx/ssl && \
	openssl req -x509 -nodes \
	-out /etc/nginx/ssl/inception.crt \
	-keyout /etc/nginx/ssl/inception.key \
	-subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=tanota.42.fr/UID=tanota"

# copy the config file to the container
RUN mkdir -p /var/run/nginx
COPY ./conf/nginx.conf /etc/nginx/nginx.conf

# give permissions on dir
RUN chmod 755 /var/www/html
RUN chown -R www-data:www-data /var/www/html

# run [NGINX, with the following config option, daemon off]
CMD ["nginx", "-g", "daemon off;"]
