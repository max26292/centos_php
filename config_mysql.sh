#!/bin/bash
service mysqld stop
killall mysqld
rm -f /var/lib/mysql/*
service mysqld start
__string=$(grep 'temporary password' /var/log/mysqld.log)
__pass=${__string:(-12)}
__root_pass="#Hitman5066789"
echo "############### Run config script #################"
echo "##Config mysql##"
echo "[mysqld]"                                         > /etc/my.cnf
echo "# join_buffer_size = 128M"                       >> /etc/my.cnf
echo "# sort_buffer_size = 2M"                         >> /etc/my.cnf
echo "# read_rnd_buffer_size = 2M"                     >> /etc/my.cnf
echo "datadir=/var/lib/mysql"                          >> /etc/my.cnf
echo "symbolic-links=0"                                >> /etc/my.cnf
echo "socket=/usr/local/bin/mysql.sock"                >> /etc/my.cnf
echo "port = 3306"                                     >> /etc/my.cnf
echo "bind-address = 0.0.0.0"                          >> /etc/my.cnf
echo "# skip-networking"                               >> /etc/my.cnf
echo "[client]"                                        >> /etc/my.cnf
echo "socket=/usr/local/bin/mysql.sock"                >> /etc/my.cnf
echo "############### End config script #################"
########### ROOT PASSWORD #########################
echo "############## Update root password ############"
service mysqld restart
echo "Change root password"
mysqladmin -u root -p${__pass} password $__root_pass
echo "Changed"
echo "CREATE USER 'root'@'%' IDENTIFIED BY '$__root_pass' ;" | mysql --protocol=socket -uroot -p$__root_pass
echo "Change root remote access"
echo "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '$__root_pass';" | mysql --protocol=socket -uroot -p$__root_pass
echo "DROP DATABASE IF EXISTS test ;" | mysql --protocol=socket -uroot -p$__root_pass
echo "FLUSH PRIVILEGES ;" | mysql --protocol=socket -uroot -p$__root_pass
service mysqld restart
#remove password policy
echo "uninstall plugin validate_password;" | mysql -uroot -p$__root_pass
# echo "SET GLOBAL validate_password_policy = 0 ;" | mysql -uroot -p$__root_pass
# echo "SET GLOBAL validate_password_length = 0 ;" | mysql -uroot -p$__root_pass
# echo "SET GLOBAL validate_password_mixed_case_count = 0 ;" | mysql -uroot -p$__root_pass
# echo "SET GLOBAL validate_password_mixed_case_count  = 0 ;" | mysql -uroot -p$__root_pass
# echo "SET GLOBAL validate_password_special_char_count = 0 ;" | mysql -uroot -p$__root_pass  
# echo "SHOW VARIABLES LIKE 'validate_password%';"| mysql -uroot -p$__root_pass
echo "#####################################################################################"
service mysqld stop