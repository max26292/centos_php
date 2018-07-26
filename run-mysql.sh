#!/bin/bash
# /usr/local/bin/config_mysql.sh
chown -R mysql:mysql /var/lib/mysql /var/run/mysqld && \
    service mysqld start
echo "Create testdb"
echo "CREATE DATABASE ${MYSQL_DATABASE} IF NOT EXISTS;"| mysql --protocol=socket -uroot -p${MYSQL_ROOT_PASSWORD}
echo "CREATE USER '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}' ;" | mysql --protocol=socket -uroot -p${MYSQL_ROOT_PASSWORD}
echo "GRANT ALL ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%' WITH GRANT OPTION ;" | mysql --protocol=socket -uroot -p${MYSQL_ROOT_PASSWORD}