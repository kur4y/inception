#!/bin/sh

cd /var/www/html/wordpress

# Check if wordpress is already downloaded
if [ -e /var/www/wordpress/wp-config.php ]
then
	echo "Wordpress already installed"
	sleep 10
else
	echo "Configuring wordpress ..."

	# Wait for the database to be created correctly
	sleep 30

    wp config create	--allow-root \
						--dbname=$SQL_DATABASE \
						--dbuser=$SQL_USER \
						--dbpass=$SQL_PASSWORD \
    					--dbhost=mariadb:3306 \
						--path='/var/www/wordpress'

	sleep 2

	# Fill wordpress first page
	wp core install	--allow-root \
	    			--dbhost=mariadb:3306 \
					--path='/var/www/wordpress' \
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
					--path='/var/www/wordpress' >> /log.txt

	sleep 2
fi

if [ ! -d /run/php ]; then
    mkdir ./run/php
fi

echo "wordpress is configured"
/usr/sbin/php-fpm7.4 -F
