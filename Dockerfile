FROM centos:centos7.2.1511
RUN yum clean all
RUN yum -y update
RUN yum install wget -y
RUN yum -y install httpd
RUN systemctl start httpd.service
RUN systemctl enable httpd
RUN yum install mysql-server -y
RUN systemctl start mysqld
# RUN mysql_secure_installation -y
RUN systemctl enable mariadb.service
RUN yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm -y
RUN  yum install http://rpms.remirepo.net/enterprise/remi-release-7.rpm -y
RUN  yum install yum-utils -y 
RUN  yum-config-manager --enable remi-php70
RUN  yum-config-manager --enable remi-php71
RUN yum install php php-mcrypt php-cli php-gd php-curl php-mysql php-ldap php-zip php-fileinfo -y
