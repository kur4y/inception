# start from a debian image base
FROM debian:bullseye

# update and install packages
RUN apt-get update -y && \
	apt-get install -y nginx openssl && \
	rm -rf /var/lib/apt/lists/*

# generate self-signed SSL certificates and key
RUN mkdir -p /etc/nginx/ssl && \
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/nginx.key -out /etc/nginx/ssl/nginx.crt \
    -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=tanota.42.fr/UID=tanota"

# copy the conf file inside nginx
COPY ./conf/nginx.conf /etc/nginx/nginx.conf

# expose port 443 for HTTPS
EXPOSE 443

# run NGINX
CMD ["nginx", "-g", "daemon off;"]
