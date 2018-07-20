FROM centos:centos6.9
# Install basic tools for install
RUN yum clean all
RUN yum -y update
RUN yum install wget -y
RUN yum -y install nano
RUN yum install -y yum-utils 
############ END ##################
########### INSTALL httpd #########
RUN yum install httpd -y
########### END ###################
##install mysql - php myadmin 

###
### Envs
###

# Version
# Check for Updates:
# https://dev.mysql.com/downloads/repo/yum/
ENV YUM_REPO_URL="https://dev.mysql.com/get/mysql57-community-release-el6-7.noarch.rpm  "

# User/Group
ENV MY_USER="mysql"
ENV MY_GROUP="mysql"
ENV MY_UID="747"
ENV MY_GID="747"

# Files
ENV MYSQL_BASE_INCL="/etc/my.cnf.d"
ENV MYSQL_CUST_INCL1="/etc/mysql/conf.d"
ENV MYSQL_CUST_INCL2="/etc/mysql/docker-default.d"
ENV MYSQL_DEF_DAT="/var/lib/mysql"
ENV MYSQL_DEF_LOG="/var/log/mysql"
ENV MYSQL_DEF_PID="/var/run/mysqld"
ENV MYSQL_DEF_SCK="/var/sock/mysqld"

ENV MYSQL_LOG_SLOW="${MYSQL_DEF_LOG}/slow.log"
ENV MYSQL_LOG_ERROR="${MYSQL_DEF_LOG}/error.log"
ENV MYSQL_LOG_QUERY="${MYSQL_DEF_LOG}/query.log"

###
### Install
###
RUN groupadd -g ${MY_GID} -r ${MY_GROUP} && \
	adduser ${MY_USER} -u ${MY_UID} -M -s /sbin/nologin -g ${MY_GROUP}

RUN \
	yum -y install epel-release && \
	rpm -ivh ${YUM_REPO_URL} && \
	yum-config-manager --disable mysql55-community && \
	yum-config-manager --disable mysql56-community && \
	yum-config-manager --enable mysql57-community && \
	yum-config-manager --disable mysql80-community && \
	yum clean all

RUN yum -y update && yum -y install \
	mysql-community-server

RUN \
	yum clean all && \
	yum -y install hostname && \
	yum clean all


##
## Configure
##
RUN \
	rm -rf ${MYSQL_BASE_INCL} && \
	rm -rf ${MYSQL_CUST_INCL1} && \
	rm -rf ${MYSQL_CUST_INCL2} && \
	rm -rf ${MYSQL_DEF_DAT} && \
	rm -rf ${MYSQL_DEF_SCK} && \
	rm -rf ${MYSQL_DEF_PID} && \
	rm -rf ${MYSQL_DEF_LOG} && \
	\
	mkdir -p ${MYSQL_BASE_INCL} && \
	mkdir -p ${MYSQL_CUST_INCL1} && \
	mkdir -p ${MYSQL_CUST_INCL2} && \
	mkdir -p ${MYSQL_DEF_DAT} && \
	mkdir -p ${MYSQL_DEF_SCK} && \
	mkdir -p ${MYSQL_DEF_PID} && \
	mkdir -p ${MYSQL_DEF_LOG} && \
	\
	chown -R ${MY_USER}:${MY_GROUP} ${MYSQL_BASE_INCL} && \
	chown -R ${MY_USER}:${MY_GROUP} ${MYSQL_CUST_INCL1} && \
	chown -R ${MY_USER}:${MY_GROUP} ${MYSQL_CUST_INCL2} && \
	chown -R ${MY_USER}:${MY_GROUP} ${MYSQL_DEF_DAT} && \
	chown -R ${MY_USER}:${MY_GROUP} ${MYSQL_DEF_SCK} && \
	chown -R ${MY_USER}:${MY_GROUP} ${MYSQL_DEF_PID} && \
	chown -R ${MY_USER}:${MY_GROUP} ${MYSQL_DEF_LOG} && \
	\
	chmod 0775 ${MYSQL_BASE_INCL} && \
	chmod 0775 ${MYSQL_CUST_INCL1} && \
	chmod 0775 ${MYSQL_CUST_INCL2} && \
	chmod 0775 ${MYSQL_DEF_DAT} && \
	chmod 0775 ${MYSQL_DEF_SCK} && \
	chmod 0775 ${MYSQL_DEF_PID} && \
	chmod 0775 ${MYSQL_DEF_LOG}

RUN \
	echo "[client]"                                         > /etc/my.cnf && \
	echo "socket = ${MYSQL_DEF_SCK}/mysqld.sock"           >> /etc/my.cnf && \
	\
	echo "[mysql]"                                         >> /etc/my.cnf && \
	echo "socket = ${MYSQL_DEF_SCK}/mysqld.sock"           >> /etc/my.cnf && \
	\
	echo "[mysqld]"                                        >> /etc/my.cnf && \
	echo "skip-host-cache"                                 >> /etc/my.cnf && \
	echo "skip-name-resolve"                               >> /etc/my.cnf && \
	echo "datadir = ${MYSQL_DEF_DAT}"                      >> /etc/my.cnf && \
	echo "user = ${MY_USER}"                               >> /etc/my.cnf && \
	echo "port = 3306"                                     >> /etc/my.cnf && \
	echo "bind-address = 0.0.0.0"                          >> /etc/my.cnf && \
	echo "socket = ${MYSQL_DEF_SCK}/mysqld.sock"           >> /etc/my.cnf && \
	echo "pid-file = ${MYSQL_DEF_PID}/mysqld.pid"          >> /etc/my.cnf && \
	echo "general_log_file = ${MYSQL_LOG_QUERY}"           >> /etc/my.cnf && \
	echo "slow_query_log_file = ${MYSQL_LOG_SLOW}"         >> /etc/my.cnf && \
	echo "log-error = ${MYSQL_LOG_ERROR}"                  >> /etc/my.cnf && \
	echo "!includedir ${MYSQL_BASE_INCL}/"                 >> /etc/my.cnf && \
	echo "!includedir ${MYSQL_CUST_INCL1}/"                >> /etc/my.cnf && \
	echo "!includedir ${MYSQL_CUST_INCL2}/"                >> /etc/my.cnf
VOLUME /var/lib/mysql
VOLUME /var/log/mysql
VOLUME /var/sock/mysqld
VOLUME /etc/mysql/conf.d
VOLUME /etc/mysql/docker-default.d
##########
### install phpmyadmin
##########
# RUN yum -y install phpmyadmin


## install php 7.1

RUN wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm
RUN wget http://rpms.remirepo.net/enterprise/remi-release-6.rpm
RUN rpm -Uvh remi-release-6.rpm epel-release-latest-6.noarch.rpm

RUN yum-config-manager --enable remi-php71
RUN yum install php71 -y
#RUN yum install php-xxx
#RUN yum --enablerepo=remi-php71-test install php-xxx
RUN yum install -y php php-mcrypt php-cli php-gd php-curl php-mysql php-ldap php-zip php-fileinfo 
RUN yum -y update 
RUN \
	yum -y autoremove && \
	yum clean metadata && \
	yum clean all && \
	yum -y install hostname && \
	yum clean all
#################### END of Prepair################################################
EXPOSE 80
EXPOSE 3306
EXPOSE 8080
##### end open port:wq

WORKDIR /var/www/html

### test run service script

### mysql script
COPY start.sh /usr/local/bin/
COPY config_mysql.sh /usr/local/bin/
COPY run-httpd.sh /usr/local/bin/
COPY supervisord.conf /etc/supervisord.conf

############### config files 
COPY php.ini /etc/

##############################
######### change permission ##
#############################

RUN chmod 755 /usr/local/bin/start.sh
RUN chmod -v +x /usr/local/bin/start.sh
RUN chmod 755 /usr/local/bin/config_mysql.sh
RUN chmod 755 /usr/local/bin/run-httpd.sh
#RUN ./config_mysql.sh
#RUN ./docker-entrypoint.sh
# RUN chkconfig mysqld on
# RUN chkconfig httpd on
# CMD ["mysqld_safe"]
# CMD ["exec /usr/sbin/apachectl -D FOREGROUND"]
# #CMD ["/bin/bash", "/start.sh"]

##########################################################
########## CLEAN NOT NEEDED PACKAGES

package-cleanup --leaves --all

###########################################################
## testing 
# ENTRYPOINT [ "/user/sbin" ]
RUN ln -s usr/local/bin/start.sh / # backwards compat
#ENTRYPOINT ["start.sh"]
#CMD ["mysqld_safe"]
