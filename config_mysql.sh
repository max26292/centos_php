 #!/bin/sh
__mysql_config() {
# Hack to get MySQL up and running... I need to look into it more.
echo "Running the mysql_config function."
#yum -y erase mysql mysql-server
# mkdir -p /var/run/mysql
# chown -R mysql:mysql /var/lib/mysql
# mysqld --initialize
# rm -rf /var/lib/mysql/ /etc/my.cnf
# yum -y install mysql mysql-server
# chmod 777 /var/lib/mysql
#mysql_install_db
# chown  root:root /var/lib/mysql
# mysqld_safe --skip-grant-tables &
# mysql -uroot  -e "UPDATE mysql.user SET Password=PASSWORD('mysqlPassword') WHERE User='root';FLUSH PRIVILEGES;"
/usr/bin/mysqld_safe &
sleep 10
}

__start_mysql() {
echo "Running the start_mysql function."
# mysqld_safe --skip-grant-tables 
mysql -uroot  -e "UPDATE mysql.user SET Password=PASSWORD('mysqlPassword') WHERE User='root';FLUSH PRIVILEGES;"
killall mysqld
/usr/bin/mysqld_safe &
mysqladmin -u root password mysqlPassword
mysql -uroot -pmysqlPassword -e "CREATE DATABASE testdb"
mysql -uroot -pmysqlPassword -e "GRANT ALL PRIVILEGES ON testdb.* TO 'testdb'@'localhost' IDENTIFIED BY 'mysqlPassword'; FLUSH PRIVILEGES;"
mysql -uroot -pmysqlPassword -e "GRANT ALL PRIVILEGES ON *.* TO 'testdb'@'%' IDENTIFIED BY 'mysqlPassword' WITH GRANT OPTION; FLUSH PRIVILEGES;"
mysql -uroot -pmysqlPassword -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'mysqlPassword' WITH GRANT OPTION; FLUSH PRIVILEGES;"
mysql -uroot -pmysqlPassword -e "select user, host FROM mysql.user;"
killall mysqld
sleep 10
}

# Call all functions
__mysql_config
__start_mysql
#exec service mysqld
# exec mysqld_safe