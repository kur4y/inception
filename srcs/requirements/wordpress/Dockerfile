# start from a debian image base
FROM debian:bullseye

# update and install packages
RUN apt-get update -y && \
	apt-get upgrade -y && \
	apt-get install -y wget && \
	apt-get install -y php7.3 php-fpm php-mysql && \
	rm -rf /var/lib/apt/lists/*

# download wordpress
RUN wget http://wordpress.org/wordpress-6.1.1.tar.gz -P /var/www/html && \
	tar -xvf /var/www/html/wordpress-6.1.1.tar.gz -C /var/www/html && \
	rm -rf /var/www/html/wordpress-6.1.1.tar.gz && \
	chown -R www-data:www-data /var/www/* && \
	chmod -R 755 /var/www/*

# install wp_cli command
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	chmod +x wp-cli.phar && \
	mv wp-cli.phar /usr/local/bin/wp

# copy config file & script to the container
COPY ./conf/www.conf /etc/php/7.3/fpm/pool.d/
COPY ./tools/wordpress_script.sh ./

# give rights to exec script & create tmp folder for PHP-FPM's socket files
RUN chmod +x ./wordpress_script.sh && mkdir -p /run/php

# expose port 9000 for php-fpm
EXPOSE 9000

ENTRYPOINT ["sh", "./script.sh"]
