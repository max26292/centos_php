#!/bin/bash
# /usr/local/bin/config_mysql.sh
chown -R mysql:mysql /var/lib/mysql /var/run/mysqld && \
    service mysqld start
echo "Create testdb"
#remove password policy
echo "SET GLOBAL validate_password_policy = 0 ;" | mysql --protocol=socket -uroot -p${MYSQL_ROOT_PASSWORD}
echo "SET GLOBAL validate_password_length = 3 ;" | mysql --protocol=socket -uroot -p${MYSQL_ROOT_PASSWORD}
echo "SET GLOBAL validate_password_mixed_case_count = 0 ;" | mysql --protocol=socket -uroot -p${MYSQL_ROOT_PASSWORD}
echo "SET GLOBAL validate_password_mixed_case_count  = 0 ;" | mysql --protocol=socket -uroot -p${MYSQL_ROOT_PASSWORD}
echo "SET GLOBAL validate_password_special_char_count = 0 ;" | mysql --protocol=socket -uroot -p${MYSQL_ROOT_PASSWORD}  
echo "SHOW VARIABLES LIKE 'validate_password%';"| mysql --protocol=socket -uroot -p${MYSQL_ROOT_PASSWORD}
echo "CREATE DATABASE IF NOT EXISTS  ${MYSQL_DATABASE} ;"| mysql --protocol=socket -uroot -p${MYSQL_ROOT_PASSWORD}
echo "CREATE USER '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}' ;" | mysql --protocol=socket -uroot -p${MYSQL_ROOT_PASSWORD}
echo "GRANT ALL ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%' WITH GRANT OPTION ;" | mysql --protocol=socket -uroot -p${MYSQL_ROOT_PASSWORD}