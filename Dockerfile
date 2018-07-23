FROM centos:centos6.9
# Install basic tools for install
RUN yum clean all
RUN yum -y update
RUN gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4
RUN yum install wget -y
RUN yum -y install nano
RUN yum install -y yum-utils 
############ END ##################
########### INSTALL httpd #########
RUN yum install httpd -y
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
#########
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
RUN yum clean all 
##
## Configure
##
VOLUME /var/lib/mysql
VOLUME /var/log/mysql
VOLUME /var/sock/mysqld
VOLUME /etc/mysql/conf.d
VOLUME /etc/mysql/docker-default.d
## install php 7.1

# RUN wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm
RUN wget http://rpms.remirepo.net/enterprise/remi-release-6.rpm
RUN rpm -Uvh remi-release-6.rpm 
RUN yum-config-manager --enable remi-php71
RUN yum install php71 -y
RUN yum install -y php php-mcrypt php-cli php-gd php-curl php-mysql php-ldap php-zip php-fileinfo 
RUN yum -y update 
RUN \  
    yum clean metadata && \
    yum clean all 
#################### END of Prepair################################################
EXPOSE 80
EXPOSE 3306
EXPOSE 8080
##### end open port

WORKDIR /var/www/html

### test run service script

### mysql script
COPY start.sh /usr/local/bin/
COPY config_mysql.sh /usr/local/bin/
COPY run-httpd.sh /usr/local/bin/
COPY run-mysql.sh /usr/local/bin/
COPY supervisord.conf /etc/supervisord.conf

############### config files 
COPY php.ini /etc/
COPY httpd.conf /etc/httpd/conf/
##############################
######### change permission ##
#############################

RUN chmod 755 /usr/local/bin/start.sh
RUN chmod -v +x /usr/local/bin/start.sh
RUN chmod a+x /usr/local/bin/config_mysql.sh
RUN chmod 755 /usr/local/bin/run-httpd.sh
RUN chmod 755 /usr/local/bin/run-mysql.sh
RUN chmod 777 /var/lib/mysql
RUN chmod 777 /var/lib/mysql/
##########################################################
########## CLEAN NOT NEEDED PACKAGES #####################
# RUN package-cleanup --leaves --all
RUN  yum clean all 
RUN rm -rf /var/cache/yum
RUN rm -rf /var/lib/mysql/*
###########################################################
RUN ln -s usr/local/bin/start.sh / # backwards compat
# RUN /usr/local/bin/config_mysql.sh
ENTRYPOINT ["/bin/bash","start.sh"]

