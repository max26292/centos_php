#!/bin/bash
### stop mysqld service if it running
echo "############### Stop mysqld service ################"
service mysqld stop
killall mysqld
# exec killall mysqld
## running install script with default root password
echo "############### Run install script #################"
rm -rf /var/lib/mysql/*
service mysqld start
__string=$(grep 'temporary password' /var/log/mysqld.log)
__pass=${__string:(-12)}
# echo ${__pass}
pass='#Hitman5066789'
echo "############## Update root password ############"
ln -s /var/lib/mysql/mysql.sock /tmp/mysql.sock
# echo "$SECURE_MYSQL"
mysqladmin -u root -p$(echo ${__pass}) password $pass
# echo $(echo ${pass})
##testing 
mysqladmin -u root -p$pass flush-privileges
echo "CREATE USER 'root'@'%' IDENTIFIED BY '$pass' ;" | mysql --protocol=socket -uroot -p$pass
echo "GRANT ALL ON *.* TO 'root'@'%' WITH GRANT OPTION ;" | mysql --protocol=socket -uroot -p$pass
echo "DROP DATABASE IF EXISTS test ;" | mysql --protocol=socket -uroot -p$pass
#remove password policy
echo "validate_password_length 3 ;" | mysql --protocol=socket -uroot -p$pass
echo "validate_password_mixed_case_count 0 ;" | mysql --protocol=socket -uroot -p$pass
echo "validate_password_mixed_case_count 0 ;" | mysql --protocol=socket -uroot -p$pass
echo "validate_password_policy 0 ;" | mysql --protocol=socket -uroot -p$pass
echo "validate_password_special_char_count 0 ;" | mysql --protocol=socket -uroot -p$pass  
echo "FLUSH PRIVILEGES ;" | mysql --protocol=socket -uroot -p$pass  
killall mysqld
service mysqld stop
echo "testing script"
echo "[mysqld]"                                        >> /etc/my.cnf
echo "port = 3306"                                     >> /etc/my.cnf
echo "bind-address = 0.0.0.0"                          >> /etc/my.cnf
service mysqld restart
service mysqld stop
# service mysqld start	
