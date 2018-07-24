FROM centos:centos6.9

######################################
########## Env define ################
ENV YUM_REPO_URL="https://dev.mysql.com/get/mysql57-community-release-el6-7.noarch.rpm"
# Files
ENV MYSQL_BASE_INCL="/etc/my.cnf.d"
ENV MYSQL_CUST_INCL1="/etc/mysql/conf.d"
ENV MYSQL_CUST_INCL2="/etc/mysql/docker-default.d"
ENV MYSQL_DEF_DAT="/var/lib/mysql"
ENV MYSQL_DEF_LOG="/var/log/mysql"
ENV MYSQL_LOG_SLOW="${MYSQL_DEF_LOG}/slow.log"
ENV MYSQL_LOG_ERROR="${MYSQL_DEF_LOG}/error.log"
ENV MYSQL_LOG_QUERY="${MYSQL_DEF_LOG}/query.log"
# Install basic tools for install
########## INSTALL httpd #########
RUN yum -y update && yum clean all
RUN gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4
RUN yum install wget -y && \
    yum -y install nano && \
    yum install -y yum-utils  && \
    yum install httpd -y && \ 
    yum clean all  
############ END ##################



###
### Envs
###

# Version
# Check for Updates:
# https://dev.mysql.com/downloads/repo/yum/


###
### Install
###
#########
RUN \
    yum -y install epel-release && \
    rpm -ivh ${YUM_REPO_URL} && \
    yum-config-manager --disable mysql55-community && \
    yum-config-manager --disable mysql56-community && \
    yum-config-manager --enable mysql57-community && \
    yum-config-manager --disable mysql80-community && \
    yum -y update && \    
    yum -y install ysql-community-server && \
    yum clean all
## install php 7.1
RUN wget http://rpms.remirepo.net/enterprise/remi-release-6.rpm && \
    rpm -Uvh remi-release-6.rpm && \
    yum-config-manager --enable remi-php71 && \
    yum install php71 -y && \
    yum install -y php php-mcrypt php-cli php-gd php-curl php-mysql php-ldap php-zip php-fileinfo  && \
    yum -y update && \
    yum clean metadata && \
    yum clean all 
##########################################################
########## CLEAN NOT NEEDED PACKAGES #####################
RUN package-cleanup --leaves --all && \
    yum clean all && \
    rm -rf /var/cache/yum
# RUN wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm

#################### END of Prepair################################################
##
## Configure
##
# VOLUME /var/lib/mysql
VOLUME /var/log/mysql
VOLUME /var/sock/mysqld
VOLUME /etc/mysql/conf.d
VOLUME /etc/mysql/docker-default.d
EXPOSE 80
EXPOSE 3306
EXPOSE 8080
##### end open port
WORKDIR /var/www/html
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
##############################
RUN chmod 755 /usr/local/bin/start.sh
RUN chmod -v +x /usr/local/bin/start.sh
###########################################################
RUN ln -s usr/local/bin/start.sh / # backwards compat
# RUN /usr/local/bin/config_mysql.sh
VOLUME /var/lib/mysql:rw
ENTRYPOINT ["/bin/bash","start.sh"]

