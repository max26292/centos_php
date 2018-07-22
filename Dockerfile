FROM centos:6
RUN yum clean all
RUN yum -y update
RUN gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4
RUN yum install wget -y
RUN yum install httpd -y

RUN wget http://dev.mysql.com/get/mysql57-community-release-el6-7.noarch.rpm

RUN yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm -y
#RUN  rpm -Uvh http://download.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
#RUN  rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-6.rpm
RUN yum install http://rpms.remirepo.net/enterprise/remi-release-6.rpm -y
RUN yum localinstall mysql57-community-release-el6-7.noarch.rpm -y
RUN  yum install yum-utils -y
RUN  yum-config-manager --enable remi-php71
#RUN yum install mysql-community-server -y
#RUN yum --enablerepo=remi install phpmyadmin -y
#RUN yum install php-xxx
#RUN yum --enablerepo=remi-php71-test install php-xxx
############ instal extension
RUN yum install php php-mcrypt php-cli php-gd php-curl php-mysql php-ldap php-zip php-fileinfo -y

############ install mysql and php myadmin
RUN yum install mysql-community-server -y
RUN yum --enablerepo=remi install phpmyadmin -y
RUN yum install -y nano
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
RUN chmod 755 /var/lib/mysql
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
# ENTRYPOINT ["start.sh"]
#CMD ["mysqld_safe"]
