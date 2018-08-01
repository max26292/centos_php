#!/bin/bash
# /usr/local/bin/config_mysql.sh
service mysqld start
echo "Create testdb"
#remove password policy
echo "SET GLOBAL validate_password_policy = 0 ;" | mysql -uroot -p${MYSQL_ROOT_PASSWORD}
echo "SET GLOBAL validate_password_length = 3 ;" | mysql -uroot -p${MYSQL_ROOT_PASSWORD}
echo "SET GLOBAL validate_password_mixed_case_count = 0 ;" | mysql -uroot -p${MYSQL_ROOT_PASSWORD}
echo "SET GLOBAL validate_password_mixed_case_count  = 0 ;" | mysql -uroot -p${MYSQL_ROOT_PASSWORD}
echo "SET GLOBAL validate_password_special_char_count = 0 ;" | mysql -uroot -p${MYSQL_ROOT_PASSWORD}  
echo "SHOW VARIABLES LIKE 'validate_password%';"| mysql -uroot -p${MYSQL_ROOT_PASSWORD}
echo "CREATE DATABASE IF NOT EXISTS  ${MYSQL_DATABASE} ;"| mysql -uroot -p${MYSQL_ROOT_PASSWORD}
echo "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}' ;" | mysql -uroot -p${MYSQL_ROOT_PASSWORD}
echo "GRANT ALL ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%' WITH GRANT OPTION ;" | mysql -uroot -p${MYSQL_ROOT_PASSWORD}