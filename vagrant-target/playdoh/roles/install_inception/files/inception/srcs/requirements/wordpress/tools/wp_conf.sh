#!/bin/sh

echo "having a nap\n"
sleep 20

if [ ! -f wp-config.php ]
then
	echo "Wordpress configuration\n"
	wp core config \
		--dbhost=inc_mariadb:3306 \
		--dbname="$SQL_DATABASE" \
		--dbuser="$SQL_USER" \
		--dbpass="$SQL_PSSWD" \
		--allow-root
	wp core install \
		--title="$WP_TITLE" \
		--admin_user="$WP_USERNAME" \
		--admin_password="$WP_PASSWD" \
		--admin_email="$WP_EMAIL" \
		--url="$WP_URL" \
		--allow-root

	wp config set WP_HOME "$WP_URL" --type=constant --allow-root
	wp config set WP_SITE_URL "$WP_URL" --type=constant --allow-root

	echo "plugin importer install"
	wp plugin install wordpress-importer \
		--activate \
		--allow-root && echo "wpi success"

	if [ -f /var/www/wordpress-content.xml ]
	then
		wp import /var/www/wordpress-content.xml \
			--authors=create \
			--allow-root
		
		HOMEPAGE_ID=$(wp post list \
    			--post_type=page \
    			--name=Coconut \
    			--field=ID \
    			--allow-root)

		if [ -n "$HOMEPAGE_ID" ]
		then
    			wp option update show_on_front page --allow-root
    			wp option update page_on_front "$HOMEPAGE_ID" --allow-root

    			echo "Homepage set to Coconut (ID $HOMEPAGE_ID)"
		else
    			echo "WARNING: Coconut page not found"
		fi

	else
		echo "WARNING: No WordPress XML backup found"
	fi

	# redis config
	wp config set WP_CACHE true --add --allow-root
	wp config set WP_CACHE_KEY_SALT $DOMAIN_NAME --allow-root
	wp config set WP_REDIS_HOST inc_redis --allow-root
	wp plugin install redis-cache --activate --allow-root
	wp plugin update --all --allow-root
	wp redis enable --allow-root
fi
echo "starting php-fpm\n"
exec /usr/sbin/php-fpm8.4 -F
