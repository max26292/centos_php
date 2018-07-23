#!/bin/bash

### stop mysqld service if it running
echo "stop mysqld service"
service mysqld stop
## running install script with default root password
rm -rf /var/lib/mysql/*
service mysqld start
__string=$(grep 'temporary password' /var/log/mysqld.log)
__pass=${__string:(-12)}
echo ${__pass}
pass='#Hitman5066789'
# mysql -u root -p$(echo ${__pass}) -e "UPDATE mysql.user SET Password=PASSWORD('root') WHERE User='root';FLUSH PRIVILEGES;" 
#  mysql -u root -p$(echo ${__pass}) -e "uninstall plugin validate_password"
# mysqladmin -u root -p$(echo ${__pass}) password $(echo ${pass})  
mysqladmin -u root -p$(echo ${__pass}) password $pass

##testing 
# echo "testing script"
# mysql --user=root <<_EOF_

# DELETE FROM mysql.user WHERE User='';
# DROP DATABASE IF EXISTS test;
# DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';
# FLUSH PRIVILEGES;
# _EOF_
killall mysqld
