#!/bin/sh

while ! mariadb -h$MARIADB_HOST -P${MARIADB_PORT} -u$MARIADB_USER -p$MARIADB_PASSWORD; do echo "waiting for db ..."; done
wp core config --dbhost=${MARIADB_HOST} --dbname=${MARIADB_NAME} --dbuser=${MARIADB_USER} --dbpass=${MARIADB_PASSWORD} --allow-root
wp core install --url="letumany.42.fr" --title="VASTO LORDE" --admin_user="leo" --admin_password="7777" --admin_email="leonidas.xaralambos@gmail.com" --skip-email
wp plugin install hello-dolly --activate
wp theme install twentytwenty --activate
wp plugin update --all
wp user create lagavulin lagavulin@islay.com --role=author --user_pass=lagavulin
wp post create --post_title="VASTO LORDE" --post_content="ZANGETSU" --post_status=publish --post_author="lagavulin"

php-fpm7 -F -R
