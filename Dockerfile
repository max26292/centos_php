FROM centos:6
RUN yum clean all
RUN yum -y update
RUN yum install wget -y
RUN yum install httpd -y
#RUN systemctl start httpd.service
#RUN systemctl enable httpd
RUN yum install mysql-server -y
#RUN systemctl start mysqld
# RUN mysql_secure_installation -y
#RUN systemctl enable mariadb.service
RUN yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm -y
RUN yum install http://rpms.remirepo.net/enterprise/remi-release-6.rpm -y
RUN  yum install yum-utils -y
RUN  yum-config-manager --enable remi-php71
#RUN yum install php-xxx
#RUN yum --enablerepo=remi-php71-test install php-xxx
RUN yum install php php-mcrypt php-cli php-gd php-curl php-mysql php-ldap php-zip php-fileinfo -y
#################### END of Prepair################################################
EXPOSE 80
EXPOSE 3306
EXPOSE 8080
##### end open port:wq

WORKDIR /var/www/html
### test run service script
COPY run-httpd.sh /usr/local/bin/

### mysql script
COPY start.sh /usr/local/bin/
COPY config_mysql.sh /usr/local/bin/
COPY supervisord.conf /etc/supervisord.conf

RUN chmod 755 /usr/local/bin/start.sh
RUN chmod 755 /usr/local/bin/config_mysql.sh
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
ENTRYPOINT ["start.sh"]
#CMD ["mysqld_safe"]
