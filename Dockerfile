FROM centos:centos6.9
RUN yum clean all
RUN yum -y update
RUN yum install wget -y
RUN yum install httpd -y
#RUN systemctl start httpd.service
#RUN systemctl enable httpd
# RUN yum install mysql-server -y
#RUN systemctl start mysqld
# RUN mysql_secure_installation -y
#RUN systemctl enable mariadb.service

##install mysql - php myadmin 
# RUN wget http://dev.mysql.com/get/mysql57-community-release-el6-7.noarch.rpm
# RUN rpm -iUvh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
# RUN yum localinstall mysql57-community-release-el6-7.noarch.rpm -y
RUN yum -y update
RUN yum install -y yum-utils

RUN yum -y install phpmyadmin
RUN yum -y install nano
RUN yum install mysql-community-server -y
## install php 7.7
#RUN wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm
# RUN wget http://rpms.remirepo.net/enterprise/remi-release-6.rpm
#RUN rpm -Uvh remi-release-6.rpm epel-release-latest-6.noarch.rpm

RUN yum-config-manager --enable remi-php71
RUN yum install php71
#RUN yum install php-xxx
#RUN yum --enablerepo=remi-php71-test install php-xxx
RUN yum install -y php php-mcrypt php-cli php-gd php-curl php-mysql php-ldap php-zip php-fileinfo 
RUN yum -y update 
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
## testing 
# ENTRYPOINT [ "/user/sbin" ]
RUN ln -s usr/local/bin/start.sh / # backwards compat
#ENTRYPOINT ["start.sh"]
#CMD ["mysqld_safe"]
