#!/bin/bash
# /usr/local/bin/config_mysql.sh
chown -R mysql:mysql /var/lib/mysql /var/run/mysqld && \
    service mysqld start
