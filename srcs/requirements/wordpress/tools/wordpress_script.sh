#!/bin/sh

cd /var/www/html/wordpress

# Check if wordpress is already downloaded
if [ -e /var/www/html/wordpress/wp-config.php ]
then
	echo "Wordpress already installed"

else
	echo "Configuring wordpress ..."

	# Wait for the database to be created correctly
	sleep 30

	# Setup the wp-config.php file
    wp config create	--allow-root \
						--dbname=$SQL_DATABASE \
						--dbuser=$SQL_USER \
						--dbpass=$SQL_PASSWORD \
    					--dbhost=mariadb:3306 \
						--path='/var/www/html/wordpress'

	sleep 2

	# Fill wordpress first page
	wp core install	--allow-root \
	    			--dbhost=mariadb:3306 \
					--path='/var/www/html/wordpress' \
					--url=${DOMAIN_NAME} \
					--title=${WP_TITLE} \
					--admin_user=${WP_ADMIN_LOGIN} \
					--admin_password=${WP_ADMIN_PASSWORD} \
					--admin_email=${WP_ADMIN_EMAIL} \

	sleep 2

	# Add user1
	wp user create	--allow-root \
					--role=author \
					${WP_USER1_LOGIN} \
					${WP_USER1_EMAIL} \
					--user_pass=${WP_USER1_PASSWORD} \
					--path='/var/www/html/wordpress' >> /log.txt
fi

sleep 10

if [ ! -d /run/php ]
then
    mkdir ./run/php
fi

/usr/sbin/php-fpm7.4 -F
