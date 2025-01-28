#!/bin/sh

cd /var/www/html/wordpress

# check if wordpress is already downloaded
if ! wp core is-installed;
then
	# wait for the database to be created correctly
	sleep 10

	# setup the wp-config.php file
    wp config create	--allow-root \
						--dbname=${SQL_DATABASE} \
						--dbuser=${SQL_USER} \
						--dbpass=${SQL_PASSWORD} \
    					--dbhost=${SQL_HOST} \
						--url=https://${DOMAIN_NAME};

	# fill wordpress first page
	wp core install		--allow-root \
						--url=https://${DOMAIN_NAME} \
						--title=${WP_TITLE} \
						--admin_user=${WP_ADMIN_LOGIN} \
						--admin_password=${WP_ADMIN_PASSWORD} \
						--admin_email=${WP_ADMIN_EMAIL};

	# add user1
	wp user create		--allow-root \
						--role=author \
						${WP_USER1_LOGIN} \
						${WP_USER1_EMAIL} \
						--user_pass=${WP_USER1_PASSWORD};

	# add user2
	wp user create		--allow-root \
						--role=author \
						${WP_USER2_LOGIN} \
						${WP_USER2_EMAIL} \
						--user_pass=${WP_USER2_PASSWORD};
	
	sleep 2

	wp cache flush --allow-root

	# configuration of WP site
	wp plugin install contact-form-7 --activate
	wp language core install en_US --activate

	THEME="twentytwentyfive"
	wp theme install $THEME --allow-root
	wp theme activate $THEME --allow-root
	wp theme delete twentynineteen twentytwenty
	wp plugin delete hello

	wp rewrite structure '/%postname%/'
fi

sleep 2

if [ ! -d /run/php ];
then
    mkdir /run/php;
fi

exec /usr/sbin/php-fpm7.4 -F -R
