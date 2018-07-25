#!/bin/sh
docker ps -a -q  --filter ancestor=max26292/centos_php:latest
cmdOutput=$(docker ps -a -q  --filter ancestor=max26292/centos_php:latest)
__pass="#Hitman5066789"
__database="mysql"
echo $cmdOutput
echo "docker exec -i ${cmdOutput} /usr/bin/mysqldump -u root -p$__pass $__database >backup.sql" > backup.bat
echo "cat backup.sql | docker exec -i ${cmdOutput} /usr/bin/mysqldump -u root -p$__pass $__database" > restore.bat