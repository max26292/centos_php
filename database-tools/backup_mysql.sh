#!/bin/sh
_container="centos_php:latest"
docker ps -a -q  --filter ancestor=$_container
cmdOutput=$(docker ps -a -q  --filter ancestor=centos_php:$_container)
__pass="#Hitman5066789"
__database="test_db"
echo "Creating backup and restore script for $_container image"
exec docker exec -t ${cmdOutput} /usr/bin/mysqldump -u root -p$__pass $__database > backup.sql
# echo "docker exec -i ${cmdOutput} /usr/bin/mysql -u root -p$__pass $__database < backup.sql" > restore.bat
echo "Finished"
# # Backup
# docker exec -t ${cmdOutput} /usr/bin/mysqldump -u root -p$__pass $__database > backup.sql
# # Restore
# docker exec -i ${cmdOutput} /usr/bin/mysql -u root -p$__pass $__database < backup.sql