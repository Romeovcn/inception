#!/bin/bash
# set -eux

service mariadb start;

sleep 5

# log into MariaDB as root and create database and the user
mariadb -u root -p${MARIADB_ROOT_PASSWORD} -e "CREATE DATABASE IF NOT EXISTS \`${MARIADB_DATABASE}\`;"
mariadb -u root -p${MARIADB_ROOT_PASSWORD} -e "CREATE USER IF NOT EXISTS \`${MARIADB_USER}\`@'localhost' IDENTIFIED BY '${MARIADB_PASSWORD}';"
mariadb -u root -p${MARIADB_ROOT_PASSWORD} -e "GRANT ALL PRIVILEGES ON \`${MARIADB_DATABASE}\`.* TO \`${MARIADB_USER}\`@'%' IDENTIFIED BY '${MARIADB_PASSWORD}';"
mariadb -u root -p${MARIADB_ROOT_PASSWORD} -e "FLUSH PRIVILEGES;"

mysqladmin -u root -p${MARIADB_ROOT_PASSWORD} shutdown

exec mysqld_safe

echo "MariaDB database and user were created successfully! "

# tail -f /dev/null