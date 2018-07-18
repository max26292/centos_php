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
ADD run-httpd.sh /run-httpd.sh
RUN chmod -v +x /run-httpd.sh
### mysql script
ADD ./start.sh /start.sh
ADD ./config_mysql.sh /config_mysql.sh
ADD ./supervisord.conf /etc/supervisord.conf

RUN chmod 755 /start.sh
RUN chmod 755 /config_mysql.sh
#RUN /config_mysql.sh
#CMD ["/run-httpd.sh"]
#CMD ["/bin/bash", "/start.sh"]
