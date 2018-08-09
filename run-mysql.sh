#!/bin/bash
# __root_pass="#Hitman5066789"
# service mysqld start
#remove password policy
service mysqld start 
ip=$(hostname -I)
sleep 1
echo "uninstall plugin validate_password;" | mysql -u admin -p${MYSQL_ROOT_PASSWORD} -h $ip
echo "SET GLOBAL validate_password_policy = 0 ;" | mysql -u admin -p${MYSQL_ROOT_PASSWORD}
echo "SET GLOBAL validate_password_length = 0 ;" | mysql -u admin -p${MYSQL_ROOT_PASSWORD}
echo "SET GLOBAL validate_password_mixed_case_count = 0 ;" | mysql -u admin -p${MYSQL_ROOT_PASSWORD}
echo "SET GLOBAL validate_password_mixed_case_count  = 0 ;" | mysql -u admin -p${MYSQL_ROOT_PASSWORD}
echo "SET GLOBAL validate_password_special_char_count = 0 ;" | mysql -u admin -p${MYSQL_ROOT_PASSWORD}  
echo "SHOW VARIABLES LIKE 'validate_password%';"| mysql -u admin -p${MYSQL_ROOT_PASSWORD}
# echo  "creating user database and change admin password"
# echo "SET PASSWORD FOR 'admin'@'localhost' = PASSWORD('${MYSQL_ROOT_PASSWORD}');FLUSH PRIVILEGES ;" | mysql -uroot -p$__root_pass
# echo "SET PASSWORD FOR 'admin'@'%' = PASSWORD('${MYSQL_ROOT_PASSWORD}');FLUSH PRIVILEGES ;" | mysql -uroot -p${MYSQL_ROOT_PASSWORD}
echo "CREATE DATABASE IF NOT EXISTS  ${MYSQL_DATABASE} ;"| mysql -u admin -p${MYSQL_ROOT_PASSWORD}
echo "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}' ;" | mysql -u admin -p${MYSQL_ROOT_PASSWORD}
echo "GRANT ALL ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%' WITH GRANT OPTION ; FLUSH PRIVILEGES;" | mysql -u admin -p${MYSQL_ROOT_PASSWORD}
service mysqld stop
mysqld_safe