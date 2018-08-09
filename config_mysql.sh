#!/bin/sh
# service iptables save
# service iptables stop
# chkconfig iptables off
service mysqld stop
killall mysqld
rm -rf /var/lib/mysql/*
service mysqld start
ip=$(hostname -I)
echo $ip
__string=$(grep 'temporary password' /var/log/mysqld.log)
__pass=${__string:(-12)}
__root_pass='#Hitman5066789'
echo $__pass
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
# echo "#skip-networking"                               >> /etc/my.cnf
# echo 'skip-external-locking'                           >> /etc/my.cnf
# echo 'skip-name-resolve'                               >> /etc/my.cnf
echo "[client]"                                        >> /etc/my.cnf
echo "socket=/usr/local/bin/mysql.sock"                >> /etc/my.cnf
# echo "bind-address=0.0.0.0"                          >> /etc/my.cnf
echo "############### End config script #################"
########### ROOT PASSWORD #########################
echo "############## Update root password ############"
service mysqld restart
echo "Change root password"
mysqladmin -u root -p${__pass} password $__root_pass
echo "Changed"
echo "CREATE USER 'root'@'%' IDENTIFIED BY '$__root_pass' ;" | mysql --protocol=socket -uroot -p$__root_pass
echo "Change root remote access"
echo $__root_pass
# echo "CREATE USER 'admin'@'localhost' IDENTIFIED BY '$__root_pass' "| mysql --protocol=socket -uroot -p$__root_pass
echo "CREATE USER 'admin'@'172.%.%.%' IDENTIFIED BY '$__root_pass' "| mysql --protocol=socket -uroot -p$__root_pass
# echo "GRANT ALL PRIVILEGES ON *.* TO 'admin'@'localhost' IDENTIFIED BY '$__root_pass'  WITH GRANT OPTION ; FLUSH PRIVILEGES;" | mysql --protocol=socket -uroot -p$__root_pass
echo "GRANT ALL PRIVILEGES ON *.* TO 'admin'@'172.%.%.%' IDENTIFIED BY '$__root_pass'  WITH GRANT OPTION ; FLUSH PRIVILEGES;" | mysql --protocol=socket -uroot -p$__root_pass
sleep 3
echo "DROP DATABASE IF EXISTS test ;" | mysql --protocol=socket -uroot -p$__root_pass

service mysqld stop
#remove password policy
# echo "uninstall plugin validate_password;" | mysql -uroot -p$__root_pass
# echo "SET GLOBAL validate_password_policy = 0 ;" | mysql -uroot -p$__root_pass
# echo "SET GLOBAL validate_password_length = 0 ;" | mysql -uroot -p$__root_pass
# echo "SET GLOBAL validate_password_mixed_case_count = 0 ;" | mysql -uroot -p$__root_pass
# echo "SET GLOBAL validate_password_mixed_case_count  = 0 ;" | mysql -uroot -p$__root_pass
# echo "SET GLOBAL validate_password_special_char_count = 0 ;" | mysql -uroot -p$__root_pass  
# echo "SHOW VARIABLES LIKE 'validate_password%';"| mysql -uroot -p$__root_pass
echo "#####################################################################################"
# service mysqld stop
