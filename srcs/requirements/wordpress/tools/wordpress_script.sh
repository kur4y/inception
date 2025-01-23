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

	# Setup the wp-config.php file
    wp config create	--allow-root \
						--dbname=$SQL_DATABASE \
						--dbuser=$SQL_USER \
						--dbpass=$SQL_PASSWORD \
    					--dbhost=mariadb:3306 \
						--path='/var/www/html/wordpress'

	sleep 2

	# Fill wordpress first page
	wp core install --allow-root \
					--url=${DOMAIN_NAME} \
					--title=${WP_TITLE} \
					--admin_user=${WP_ADMIN_LOGIN} \
					--admin_password=${WP_ADMIN_PASSWORD} \
					--admin_email=${WP_ADMIN_EMAIL} \
					--path=${WP_PATH};

	# Add user1
	wp user create	--allow-root \
					${WP_USER1_LOGIN} \
					${WP_USER1_EMAIL} \
					--user_pass=${WP_USER1_PASSWORD} \
					--path=${WP_PATH};

	# set the site in English & remove default themes/plugins
	wp language core install en_US --activate
	wp theme delete twentynineteen twentytwenty
	wp plugin delete hello

	touch /wordpress_installed
fi

if [ ! -d /run/php ]
then
    mkdir ./run/php
fi
/usr/sbin/php-fpm7.3 -F
