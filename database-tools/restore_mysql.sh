#!/bin/sh
_container="centos_php:latest"
docker ps -a -q  --filter ancestor=$_container
cmdOutput=$(docker ps -a -q  --filter ancestor=$_container)
__pass="#Hitman5066789"
__database="test_db"
echo "docker exec -i ${cmdOutput} /usr/bin/mysql -u root -p$__pass $__database < backup.sql" > restore.bat
echo "Finished"