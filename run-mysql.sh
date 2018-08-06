#!/bin/bash
__root_pass="#Hitman5066789"
service mysqld start
echo "uninstall plugin validate_password;" | mysql -uroot -p$__root_pass
echo  "creating user database and change root password"
echo "SET PASSWORD FOR 'root'@'localhost' = PASSWORD('${MYSQL_ROOT_PASSWORD}');FLUSH PRIVILEGES ;" | mysql -uroot -p$__root_pass
echo "SET PASSWORD FOR 'root'@'%' = PASSWORD('${MYSQL_ROOT_PASSWORD}');FLUSH PRIVILEGES ;" | mysql -uroot -p${MYSQL_ROOT_PASSWORD}
echo "CREATE DATABASE IF NOT EXISTS  ${MYSQL_DATABASE} ;"| mysql -uroot -p${MYSQL_ROOT_PASSWORD}
echo "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}' ;" | mysql -uroot -p${MYSQL_ROOT_PASSWORD}
echo "GRANT ALL ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%' WITH GRANT OPTION ;" | mysql -uroot -p${MYSQL_ROOT_PASSWORD}
echo "FLUSH PRIVILEGES ;" | mysql -uroot -p${MYSQL_ROOT_PASSWORD} 
service mysqld restart