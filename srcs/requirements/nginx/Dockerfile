# start from a debian image base
FROM debian:buster

# update and install packages
RUN apt-get update -y && \
	apt-get install -y nginx openssl && \
	rm -rf /var/lib/apt/lists/*

# create directory for SSL certificates
RUN mkdir -p /etc/nginx/ssl

# generate self-signed SSL certificates and key
RUN openssl req -x500 -nodes -days 365 \
		-out /etc/nginx/ssl/tanota.crt \
		-keyout /etc/nginx/ssl/tanota.key \
		-subj "/C=FR/ST=Paris/L=Paris/O=42/OU=tanota/CN=tanota/"

# copy the conf file inside nginx
COPY ./conf/nginx.conf /etc/nginx/nginx.conf

# expose port 443 for HTTPS
EXPOSE 443

# run NGINX
CMD ["nginx", "-g", "daemon off;"]
