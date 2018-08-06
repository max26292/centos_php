#!/bin/bash
### stop mysqld service if it running
echo "############### Stop mysqld service ################"
service mysqld stop
killall mysqld
# exec killall mysqld
## running install script with default root password
echo "############### Run install script #################"
echo "##Config mysql##"
sed -i 's/socket=\/var\/lib\/mysql\/mysql.sock/\#socket=\/var\/lib\/mysql\/mysql.sock/g' /etc/my.cnf
echo "[mysqld]"                                        >> /etc/my.cnf
echo "port = 3306"                                     >> /etc/my.cnf
echo "bind-address = 0.0.0.0"                          >> /etc/my.cnf
echo "socket=/usr/local/bin/mysql.sock"                >> /etc/my.cnf
echo "[client]"                                        >> /etc/my.cnf
echo "socket=/usr/local/bin/mysql.sock"                >> /etc/my.cnf
rm -rf /var/lib/mysql/*
service mysqld start
__string=$(grep 'temporary password' /var/log/mysqld.log)
__pass=${__string:(-12)}
# echo ${__pass}
########### ROOT PASSWORD #########################
echo "############## Update root password ############"
# cp /var/lib/mysql/mysql.sock /usr/local/bin/
# echo "$SECURE_MYSQL"
mysqladmin -u root -p$(echo ${__pass}) password ${MYSQL_ROOT_PASSWORD}
# echo $(echo ${pass})
##testing 
mysqladmin -u root -p${MYSQL_ROOT_PASSWORD} flush-privileges
echo "CREATE USER 'root'@'%' IDENTIFIED BY '$pass' ;" | mysql --protocol=socket -uroot -p${MYSQL_ROOT_PASSWORD}
echo "GRANT ALL ON *.* TO 'root'@'%' WITH GRANT OPTION ;" | mysql --protocol=socket -uroot -p${MYSQL_ROOT_PASSWORD}
echo "DROP DATABASE IF EXISTS test ;" | mysql --protocol=socket -uroot -p${MYSQL_ROOT_PASSWORD}
echo "FLUSH PRIVILEGES ;" | mysql --protocol=socket -uroot -p${MYSQL_ROOT_PASSWORD} 
killall mysqld
service mysqld stop
# echo "##Config mysql##"
# sed -i 's/socket=\/var\/lib\/mysql\/mysql.sock/\#socket=\/var\/lib\/mysql\/mysql.sock/g' /etc/my.cnf
# echo "[mysqld]"                                        >> /etc/my.cnf
# echo "port = 3306"                                     >> /etc/my.cnf
# echo "bind-address = 0.0.0.0"                          >> /etc/my.cnf
# echo "socket=/usr/local/bin/mysql.sock"                >> /etc/my.cnf
# echo "[client]"                                        >> /etc/my.cnf
# echo "socket=/usr/local/bin/mysql.sock"                >> /etc/my.cnf
service mysqld restart
service mysqld stop
# service mysqld start	
