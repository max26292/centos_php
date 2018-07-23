#!/bin/bash

### stop mysqld service if it running
echo "############### Stop mysqld service ################"
service mysqld stop
## running install script with default root password
echo "############### Run install script #################"
rm -rf /var/lib/mysql/*
service mysqld start
__string=$(grep 'temporary password' /var/log/mysqld.log)
__pass=${__string:(-12)}
echo ${__pass}
pass='#Hitman5066789'
# mysql -u root -p$(echo ${__pass}) -e "UPDATE mysql.user SET Password=PASSWORD('root') WHERE User='root';FLUSH PRIVILEGES;" 
#  mysql -u root -p$(echo ${__pass}) -e "uninstall plugin validate_password"
# mysqladmin -u root -p$(echo ${__pass}) password 
echo "############## Update root password ############"
# spawn mysqladmin -u root -p$__pass password 
# expect \"New password:\"
# send \"$pass\r\"
# expect \"Change the root password?\"
# send \"n\r\"
# expect eof

# echo "$SECURE_MYSQL"
mysqladmin -u root -p$(echo ${__pass}) password $pass
echo $(echo ${pass})
##testing 
echo "testing script"
mysqladmin -u root -p$pass flush-privileges
killall mysqld
# exec mysqld_safe
service mysqld start
