 #!/bin/bash
echo "start up httpd"
#config hostname
SERVER_NAME_FILE=/etc/httpd/conf.d/servername.conf
if [ ! -f "$SERVER_NAME_FILE" ]; then
  echo "ServerName $(hostname)" > $SERVER_NAME_FILE
  echo "ServerName $(hostname)"
fi
# clean up if container is being restarted
# exec rm -rf /var/run/httpd/*
# run apache
#exec  service httpd start
apachectl -D FOREGROUND
#exec service httpd start
                             