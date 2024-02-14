#!/bin/bash
# set -eux

cd /var/www/html/wordpress

if ! wp core is-installed --allow-root; then
sleep 10

wp config create --allow-root --dbname=${MARIADB_DATABASE} \
			--dbuser=${MARIADB_USER} \
			--dbpass=${MARIADB_PASSWORD} \
			--dbhost=${MARIADB_HOST} \
			--url=https://${DOMAIN_NAME};

wp core install --allow-root \
			--url=https://${DOMAIN_NAME} \
			--title=${SITE_TITLE} \
			--admin_user=${ADMIN_USER} \
			--admin_password=${ADMIN_PASSWORD} \
			--admin_email=${ADMIN_EMAIL};

wp user create --allow-root \
			${USER1_LOGIN} ${USER1_MAIL} \
			--role=author \
			--user_pass=${USER1_PASS} ;

wp cache flush --allow-root

wp plugin install contact-form-7 --allow-root --activate

wp language core install en_US --allow-root --activate

fi

if [ ! -d /run/php ]; then
	mkdir /run/php;
fi

# start the PHP FastCGI Process Manager (FPM) for PHP version 7.4 in the foreground
exec /usr/sbin/php-fpm7.4 -F -R
