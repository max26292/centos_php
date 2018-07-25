 #!/bin/bash
__run_supervisor() {
echo "###########  Running all server services  ##################"
#
# supervisor -n
}
echo "################## CHANGE SH FILE PERMISSION ##################"
chmod 755 /usr/local/bin/run-httpd.sh
chmod 755 /usr/local/bin/run-mysql.sh

# # Call all functions
echo "################## EXECUTE SH SCRIPT ##################"
bash -x /usr/local/bin/run-mysql.sh & /usr/local/bin/run-httpd.sh
# bash -x  /usr/local/bin/config_mysql.sh
__run_supervisor
# 

