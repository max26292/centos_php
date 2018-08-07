FROM centos:centos6.9

######################################
########## Env define ################
ENV YUM_REPO_URL="https://dev.mysql.com/get/mysql57-community-release-el6-7.noarch.rpm" \
# Files
    MYSQL_BASE_INCL="/etc/my.cnf.d" \
    MYSQL_CUST_INCL1="/etc/mysql/conf.d" \
    MYSQL_CUST_INCL2="/etc/mysql/docker-default.d" \
    MYSQL_DEF_DAT="/var/lib/mysql" \
    MYSQL_DEF_LOG="/var/log/mysql" 
    # MYSQL_ROOT_PASSWORD='#Hitman5066789'  
# Install basic tools for install
########## INSTALL httpd #########
RUN yum -y update && yum clean all && \
    gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 && \
    yum install wget -y && \
    yum -y install nano && \
    yum install -y yum-utils  && \
    yum install httpd -y && \ 
    yum clean all   && \
############ END ##################
# Check for Updates:
# https://dev.mysql.com/downloads/repo/yum/
    yum -y install epel-release && \
    rpm -ivh ${YUM_REPO_URL} && \
    yum-config-manager --disable mysql55-community && \
    yum-config-manager --disable mysql56-community && \
    yum-config-manager --enable mysql57-community && \
    yum-config-manager --disable mysql80-community && \
    yum -y update && \    
    yum -y install mysql-community-server && \
    yum clean all &&\
## install php 7.1
    rpm -iUvh http://rpms.remirepo.net/enterprise/remi-release-6.rpm  && \
    yum-config-manager --enable remi-php71 && \
    yum install php71 -y && \
    yum install -y php php-mcrypt php-cli php-gd php-curl php-mysql php-ldap php-zip php-fileinfo php-xml && \
    yum -y update && \
    yum clean metadata && \
    yum clean all && \
##########################################################
########## CLEAN NOT NEEDED PACKAGES #####################
    package-cleanup --leaves --all && \
    yum clean all && \
    rm -rf /var/cache/yum
# RUN wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm
#################### END of Prepair################################################
##
## Configure
##
EXPOSE 80 3306 9000 8080
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
RUN chmod 777 /usr/local/bin/start.sh && \
    chmod 755 /usr/local/bin/config_mysql.sh && \
    chmod 777 /var/lib/mysql && \
    chmod 777 /var/lib/mysql/ && \
    chmod 777 /usr/local/bin && \
   /usr/local/bin/config_mysql.sh && \  
###########################################################
    ln -s usr/local/bin/start.sh / # backwards compat && \
############# install composer for laravel ################
    curl -sS https://getcomposer.org/installer | php && \ 
    mv composer.phar /usr/local/bin/composer    
# ADDITIONAL EXTENSION #####################################
########## 
#### END ADDITONAL EXTENSION
VOLUME /var/lib/mysql
ENTRYPOINT ["/bin/bash","start.sh"]
