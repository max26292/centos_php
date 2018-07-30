#!/bin/sh
########## CAUTION please correct the below line as same as the container you wanna backup ####################
_container="max26292/centos_php:latest"
docker ps -a -q  --filter ancestor=$_container
cmdOutput=$(docker ps -a -q  --filter ancestor=$_container)
########### ROOT PASS #######################
__pass="#Hitman5066789"
############# database name #################
__database="test_db"
echo "Creating backup and restore script for $_container image"
echo "docker exec -t $cmdOutput /usr/bin/mysqldump -u root -p$__pass $__database > backup.sql" > backup.bat
# echo "docker exec -i ${cmdOutput} /usr/bin/mysql -u root -p$__pass $__database < backup.sql" > restore.bat
echo "Finished"
